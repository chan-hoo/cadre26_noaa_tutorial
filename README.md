# Quick Start Guide

1. Clone this repository:
```
git clone https://github.com/chan-hoo/cadre26_noaa_tutorial
```

2. Check JEDI input YAML files and modify them as needed:
```
cd input_yaml
```
- Day1:
```
cp Day1/jedi_3dvar* .
vim jedi_3dvar_fv3_2024022400.yaml
vim jedi_3dvar_fv3inc_2024022400.yaml
```
- Day2:
```
cp Day2/[case_name]/jedi_3dvar* .
vim jedi_3dvar_fv3_2024022400.yaml
```
- Day3:
```
cp Day3/[case_name]/jedi_3dvar* .
vim jedi_3dvar_fv3_2024022400.yaml
```

3. Open job-card script:
```
cd ..
vim run_3dvar_[platform].sh
```
where `[platform]` is `ursa`, `hercules`, or `orion`.

4. Check account (project) name and change it:

5. Submit job-card script:
```
sbatch run_3dvar_[platform].sh
```

6. Check log file:
```
vim log.cadre26.[job_id]
```

7. Move to experimental case directory:
```
cd exp_case/cadre26.[job_id]
```

8. Move to diagnostics directory:
```
cd diagnostics
```

9. Load python environment:
```
source load_py_env.[ploatform]
```

10. Check YAML files for diagnostics:
```
vim diag_fv3-jedi_obs.yaml
vim diag_fv3-jedi-tiles_[option].yaml
```

11. Run python scripts:
```
./increment_maps_tiles.py --yaml diag_fv3-jedi-tiles_[option].yaml
./obs_diagnostic.py --yaml diag_fv3-jedi_obs.yaml
./spectra_analysis_tiles.py --yaml diag_fv3-jedi-tiles_[option].yaml
```
