# Quick Start Guide

1. Check JEDI input YAML files and modify them as needed:
```
cd input_yaml
```
- FV3-JEDI YAML file:
```
vim jedi_3dvar_fv3_2024022400.yaml
```
- FV3-JEDI increment YAML file:
```
vim jedi_3dvar_fv3inc_2024022400.yaml
```

2. Open job-card script:
```
cd ..
vim run_3dvar_[platform].sh
```

3. Check account (project) name and change it:

4. Submit job-card script:
```
sbatch run_3dvar_[platform].sh
```

5. Check log file:
```
vim log.cadre26.[job_id]
```

6. Move to experimental case directory:
```
cd exp_case/cadre26.[job_id]
```

7. Move to plot directory:
```
cd plot
```

8. Load python environment:
```
source load_py_env.[ploatform]
```

9. Check YAML files for plotting:
```
vim plot_[option].yaml
```

10. Run plotting scripts:
```
./plot_[option].py
```
