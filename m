From: John Spray <jspray@redhat.com>
Subject: Re: proposal for fine-grain dout control
Date: Fri, 18 Nov 2016 14:14:09 +0000
Message-ID: <CALe9h7eQsr9mq_A6Rc62y3hhPKWfSWPO6Tny26eR+iDgfhUrGw@mail.gmail.com>
References: <20161117043223.GA22459@T530I>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:35992 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752731AbcKROOb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Nov 2016 09:14:31 -0500
Received: by mail-qt0-f175.google.com with SMTP id w33so156977010qtc.3
        for <ceph-devel@vger.kernel.org>; Fri, 18 Nov 2016 06:14:30 -0800 (PST)
In-Reply-To: <20161117043223.GA22459@T530I>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: caifeng.zhu@uniswdc.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Nov 17, 2016 at 4:32 AM,  <caifeng.zhu@uniswdc.com> wrote:
> Currently dout control is based on module and trace level.
> In practice, we find that it is much easier to control dout
> by specifying module, file, function and line, as done by
> kernel rbd/cephfs client module. The paragraphs below try to
> propose a way to implement similar control at the ceph server
> side.

Are you aware of the existing LTTng tracepoint support in Ceph?  Can
you talk about why you want to do fine-grained dout control instead of
using LTTng for this?

John

>
> As the kernel clients, we can define control points (called
> doutpoints later) for dout in the macro dout_impl and collect
> them into a seperate ELF section, like below:
>
>  #define dout_impl(cct, sub, v)                                         \
>    do {                                                                 \
> -  if (cct->_conf->subsys.should_gather(sub, v)) {                      \
> +  static doutpoint_t *_dop;                                            \
> +  DOUTPOINT(TOSTR(sub), __FILE__, __func__, __LINE__);                 \
> +                                                                       \
> +  if (cct->_conf->subsys.should_gather(sub, v) ||                      \
> +      doutpoint_active(_dop)) {                                        \
>
> In the above code, DOUTPOINT will define a doutpoint and ask linker
> to collect it into an ELF section, such as "set_doutpoint". Instead of
> adding __attribute__((section("set_doutpoint"))) to variables, we resort
> to inline ASM like below:
>
> +typedef struct doutpoint {
> +       const char *    dop_module;     // module
> +       const char *    dop_file;       // file name
> +       const char *    dop_func;       // function name
> +       int             dop_line;       // line no
> +       volatile int    dop_state;      // state 0:off, 1:on
> +} doutpoint_t;
>
> +#define        TOSTR(a)        #a
> +#define DOUTPOINT(module, file, func, line)                             \
> +do {                                                                    \
> +   __asm__(".pushsection set_doutpoint, \"aw\", @progbits" "\n"         \
> +           ".align 32"   "\n"                                           \
> +           "416:"        "\n"                                           \
> +           ".quad %c1"   "\n"                                           \
> +           ".quad %c2"   "\n"                                           \
> +           ".quad %c3"   "\n"                                           \
> +           ".long %c4"   "\n"                                           \
> +           ".long 0"     "\n"                                           \
> +           ".popsection" "\n"                                           \
> +           "leaq 416b(%%rip), %0" "\n"                                  \
> +           : "=r"(_dop)                                                 \
> +           : "i"(module), "i"(file), "i"(func), "i"(line));             \
> +} while(0)
>
> The reason for inline ASM is that: in C++, there are inline and template
> functions. static variables defined in these functions will be automatically
> added attributes by the compiler. thus it impossible to collect all doutpoints
> into one section.
>
> There is another problem to consider: collect doutpoints of shared libs into
> the main executable. We solve the problem by defining a constructor function
> and a weak function. The contructor function will automatically register doupoints
> of shared libs into the main executable. The weak function is to be overriden by
> the main executable, providing where to register doutponits.
>
> //
> // in common/dout.h
> //
> +typedef struct doutsection {
> +       doutpoint_t *   start;
> +       doutpoint_t *   stop;
> +} doutsection_t;
>
> //
> // in common/dout.cc
> //
> +extern doutpoint_t __start_set_doutpoint[]
> +       __attribute__((weak, visibility("hidden")));
> +extern doutpoint_t __stop_set_doutpoint[]
> +       __attribute__((weak, visibility("hidden")));
> +
> +extern void doutsection_global(doutsection_t **s, int *n)
> +       __attribute__((weak));
> +
> +
> +static void
> +doutsection_array(doutsection_t **s, int *n)
> +{
> +       static doutsection_t _sections[10];
> +
> +       /*
> +        * If doutsection_global is defined, provide
> +        * from the global one; otherwise, fall back
> +        * to local ones.
> +        */
> +       if (doutsection_global)
> +               doutsection_global(s, n);
> +       else {
> +               *s = _sections;
> +               *n = 10;
> +       }
> +}
> +
> +/*
> + * The 'contructor' attribute means the function will be
> + * called after dynamic linking for the library or before
> + * entering into main for the executable.
> + */
> +void __attribute__((constructor))
> +doutpoint_register(void)
> +{
> +       int i, n;
> +       doutsection_t *s;
> +
> +       doutsection_array(&s, &n);
> +       for (i = 0; i < n; i++, s++) {
> +               if (!s->start) {
> +                       s->start = __start_set_doutpoint;
> +                       s->stop = __stop_set_doutpoint;
> +                       return;
> +               }
> +       }
> +}
>
> //
> // in global/global_init.cc
> //
> void
> doutsection_global(doutsection_t **s, int *n)
> {
>         static doutsection_t _sections[10];
>
>         *s = _sections;
>         *n = 10;
> }
>
> There are some shortcomings of the proposal: mainly archtecture
> dependency and compiler dependency. DOUTPOINT exploits one x86
> instruction; weak symbol support may be different on different
> compilers.
>
> Glad and eager to hear your opinions!
> If it is useful, I'll post the whole patch.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
