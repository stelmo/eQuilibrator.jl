using Test

using eQuilibrator
using Measurements
using Unitful

eq = eQuilibrator.Equilibrator()

@testset "eQuilibrator tests" begin

    @testset "equilibrator_type" begin
        # test getters and setters
        set_temperature(eq, 310u"K")
        @test get_temperature(eq) == 310u"K"

        set_ionic_strength(eq, 0.22u"M")
        @test get_ionic_strength(eq) == 0.22u"M"

        set_pH(eq, 7.9)
        @test get_pH(eq) == 7.9

        set_pMg(eq, 2.0)
        @test get_pMg(eq) == 2.0

        # test rest
        reset_equilibrator(eq)
        @test get_temperature(eq) == 298.15u"K"
        @test get_pH(eq) == 7.5
        @test get_pMg(eq) == 3.0
        @test get_ionic_strength(eq) == 0.25u"M"
    end

    @testset "utils" begin
        @test eQuilibrator._parse_units("kilojoule") == "kJ"
        r_str = "atp + h2o = adp + pi"

        @test bigg(r_str) ==
              "bigg.metabolite:atp + bigg.metabolite:h2o = bigg.metabolite:adp + bigg.metabolite:pi"
        @test kegg(r_str) == "kegg:atp + kegg:h2o = kegg:adp + kegg:pi"
        @test metanetx(r_str) ==
              "metanetx.chemical:atp + metanetx.chemical:h2o = metanetx.chemical:adp + metanetx.chemical:pi"
        @test chebi(r_str) == "CHEBI:atp + CHEBI:h2o = CHEBI:adp + CHEBI:pi"
    end

    @testset "univariate_reaction" begin
        # set to values in code examples
        set_temperature(eq, 298.15u"K")
        set_ionic_strength(eq, 0.25u"M")
        set_pH(eq, 7.4)
        set_pMg(eq, 3.0)
        r_str = "atp + h2o = adp + pi"

        ΔGstd = ustrip(u"kJ/mol", standard_dg_prime(eq, bigg(r_str)))
        @test ΔGstd.val ≈ -29.14 atol = 0.01
        @test ΔGstd.err ≈ 0.3 atol = 0.01

        ΔGphys = ustrip(u"kJ/mol", physiological_dg_prime(eq, bigg(r_str)))
        @test ΔGphys.val ≈ -46.26 atol = 0.01
        @test ΔGphys.err ≈ 0.3 atol = 0.01

        concentrations =
            Dict(bigg("atp") => 1u"mM", bigg("adp") => 100u"μM", bigg("pi") => 0.003u"M")

        ΔGprime =
            ustrip(u"kJ/mol", dg_prime(eq, bigg(r_str); concentrations = concentrations))
        @test ΔGprime.val ≈ -49.24 atol = 0.01
        @test ΔGprime.err ≈ 0.3 atol = 0.01

        rev_ind = ln_reversibility_index(eq, bigg(r_str))
        @test rev_ind.val ≈ -12.45 atol = 0.01
        @test rev_ind.err ≈ 0.08 atol = 0.01

        # test non-trivial reaction stoichiometry parsing
        rubisco = "rb15bp + co2 + h2o = 2 3pg"
        ΔGprime = ustrip(u"kJ/mol", standard_dg_prime(eq, bigg(rubisco)))
        @test ΔGprime.val ≈ -30.85 atol = 0.01

        # using a mixed reaction string
        mixed = "bigg.metabolite:atp + CHEBI:15377 = metanetx.chemical:MNXM7 + bigg.metabolite:pi"
        ΔGprime = ustrip(u"kJ/mol", standard_dg_prime(eq, mixed))
        @test ΔGprime.val ≈ -29.14 atol = 0.01
    end

    @testset "multivariate_reaction" begin
        ntp3 = "gtp + h2o = gdp + pi"
        adk3 = "adp + gdp = amp + gtp"

        μ, Q = standard_dg_prime_multi(
            eq,
            bigg.([ntp3, adk3]);
            uncertainty_representation = "fullrank",
        )

        @test ustrip(u"kJ/mol", μ[1]) ≈ -26.458180516735318 atol = 1e-4
        @test ustrip(u"kJ/mol", μ[2]) ≈ -2.9528792110924087 atol = 1e-4

        @test ustrip(u"kJ/mol", Q[1, 1]) ≈ -1.3542171841954138 atol = 1e-4
        @test ustrip(u"kJ/mol", Q[1, 2]) ≈ 0.0 atol = 1e-4
        @test ustrip(u"kJ/mol", Q[2, 1]) ≈ 1.2988666075161392 atol = 1e-4
        @test ustrip(u"kJ/mol", Q[2, 2]) ≈ -0.3082907615275239 atol = 1e-4
    end

    @testset "multicompartment_reaction" begin
        cyto_rxn = bigg("adp + pi = 4 h + h2o + atp")
        peri_rxn = bigg("4 h =")

        ψ = -0.17u"V"
        peri_ionic = 0.20u"M"
        peri_pMg = 3.0
        peri_pH = 7.0

        set_ionic_strength(eq, 250u"mM")
        set_pH(eq, 7.4)
        set_pMg(eq, 3.0)

        dg = multi_compartmental_standard_dg_prime(
            eq,
            cyto_rxn,
            peri_rxn;
            potential_difference = ψ,
            pH_outer = peri_pH,
            pMg_outer = peri_pMg,
            ionic_strength_outer = peri_ionic,
        )

        @test ustrip(u"kJ/mol", dg).val ≈ -45.59324113925093 atol = 1e-4
        @test ustrip(u"kJ/mol", dg).err ≈ 0.30427785529910256 atol = 1e-4
    end

    @testset "formation" begin
        mets = bigg.(["atp", "adp", "amp", "pi", "h2o"])

        set_temperature(eq, 298.15u"K")
        set_ionic_strength(eq, 0.25u"M")
        set_pH(eq, 7.4)
        set_pMg(eq, 3.0)

        standard_dgf_prime_mu, standard_dgf_cov = standard_dg_formation(eq, mets)

        @test ustrip(u"kJ/mol", standard_dgf_prime_mu[1]) ≈ -2270.4800916865584 atol = 1e-4
        @test ustrip(u"kJ/mol", standard_dgf_prime_mu[2]) ≈ -1395.6292467273274 atol = 1e-4
        @test ustrip(u"kJ/mol", standard_dgf_prime_mu[3]) ≈ -521.0449892833246 atol = 1e-4
        @test ustrip(u"kJ/mol", standard_dgf_prime_mu[4]) ≈ -1056.0794480718703 atol = 1e-4
        @test ustrip(u"kJ/mol", standard_dgf_prime_mu[5]) ≈ -152.0841309000395 atol = 1e-4

        @test ustrip(u"kJ/mol", standard_dgf_cov[1, 1]) ≈ 2.220056919789737 atol = 1e-4
        @test ustrip(u"kJ/mol", standard_dgf_cov[3, 3]) ≈ 1.4330175346264344 atol = 1e-4
        @test ustrip(u"kJ/mol", standard_dgf_cov[2, 1]) ≈ 1.695559565984625 atol = 1e-4
        @test ustrip(u"kJ/mol", standard_dgf_cov[3, 5]) ≈ 0.06507547358365794 atol = 1e-4
    end
end
