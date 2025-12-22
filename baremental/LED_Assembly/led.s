/* LED Assembly for i.MX6 */

.global _start

_start:
    /* 1. Clock enable for GPIO1 */
    ldr r1, =0xFFFFFFFF
    ldr r0, =0x020C406C /* CCM_CCGR1 */
    @ ldr r1, =0x0C000000 /* Enable GPIO1 clock */
    str r1, [r0]

    ldr r0, =0x020C4070 /* CCM_CCGR2 */
    @ ldr r1, =0x0000C030
    str r1, [r0]

    ldr r0, =0x020C4074 /* CCM_CCGR3 */
    @ ldr r1, =0xC0000000
    str r1, [r0]

    ldr r0, =0x020C4078 /* CCM_CCGR4 */
    @ ldr r1, =0x0000003C
    str r1, [r0]

    /* 2. Set pin as GPIO (IOMUXC_SW_MUX_CTL_PAD_GPIO1_IO03) */
    ldr r0, =0x020E0068
    ldr r1, =0x5          /* ALT5 = GPIO mode */
    str r1, [r0]

    /* 3. Configure pad settings (IOMUXC_SW_PAD_CTL_PAD_GPIO1_IO03) */
    ldr r0, =0x020E02F4
    ldr r1, =0x000010B0  /* Typical pad settings */
    str r1, [r0]

    /* 4. Set GPIO direction (GPIO1_GDIR) */
    ldr r0, =0x0209C004  /* GPIO1_GDIR address */
    ldr r1, =0x00000008  /* Set bit3 as output (1<<3) */
    str r1, [r0]

    /* 5. Turn ON LED (set output low if LED is active-low) */
    ldr r0, =0x0209C000  /* GPIO1_DR address */
    ldr r1, =0x00000000  /* Clear bit3 to turn ON LED */
    str r1, [r0]

loop:
    b loop
    