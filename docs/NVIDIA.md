# NVIDIA limitations

The portable image intentionally defaults to the open in-kernel graphics stack for Intel and AMD. Proprietary NVIDIA drivers are not enabled because one image cannot safely choose the correct proprietary branch for every GPU generation, and hybrid-laptop PRIME bus IDs vary by computer.

Consequences:

- Modern NVIDIA GPUs may fall back to Nouveau and can have reduced performance, missing power management or display issues.
- Some hybrid laptops route external ports through the NVIDIA GPU and may not light those displays with the default configuration.
- Enabling `hardware.nvidia` globally reduces portability and can break older cards that need a legacy driver.

For a known NVIDIA computer, create a separate host profile with the correct NixOS NVIDIA options and PRIME bus IDs. Keep the generic image unchanged. Test that profile from the UEFI Boot Menu before relying on it; never run `nvidia-xconfig` against this declarative setup.
