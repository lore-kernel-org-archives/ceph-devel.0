From: kefu chai <tchaikov@gmail.com>
Subject: Re: Luminous RC1 build.c can't pass compile
Date: Wed, 19 Jul 2017 21:59:57 +0800
Message-ID: <CAJE9aON5_y+j0+EHq27vHS-gfQ4_8XZA34snNNd4BA3z2z1xGQ@mail.gmail.com>
References: <000801d3005b$8648d3a0$92da7ae0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:37945 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753354AbdGSN77 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jul 2017 09:59:59 -0400
Received: by mail-vk0-f44.google.com with SMTP id o19so634687vkd.5
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jul 2017 06:59:58 -0700 (PDT)
In-Reply-To: <000801d3005b$8648d3a0$92da7ae0$@com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dun Pengcheng <dunpengcheng@126.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jul 19, 2017 at 2:52 PM, Dun Pengcheng <dunpengcheng@126.com> wrote=
:

Pengcheng, you might want to change your local to C. before running
make. so the error message can be read by people who don't speak
Chinese.

and https://github.com/ceph/ceph/pull/16424 should address this issue.

> All:
>
> I download Luminous RC1 code and try to make compile environment on my ma=
chine. After installing so many required packages in my CentOS 7.1, I got =
=E2=80=9CMakefile=E2=80=9D in the root directory from =E2=80=9Ccmake -LH=E2=
=80=9D command.  After that, I input "make" command to build the branch, Bu=
t I found "build.c" can't pass compile. Messages are followed.
>
> [root@cephadmin ceph-12.1.0]# make
> [  0%] Built target Boost
> [  0%] Built target Boost.boost
> [  0%] Built target compressor_objs
> [  1%] Building C object src/CMakeFiles/crush_objs.dir/crush/builder.c.o
> In file included from /root/code/ceph-12.1.0/src/crush/builder.c:5:0:
> /root/code/ceph-12.1.0/src/include/assert.h:25:1: =E9=94=99=E8=AF=AF=EF=
=BC=9A=E6=9C=AA=E7=9F=A5=E7=9A=84=E7=B1=BB=E5=9E=8B=E5=90=8D=E2=80=98class=
=E2=80=99


seems you are building builder.c using c++

>  class CephContext;
>  ^
> /root/code/ceph-12.1.0/src/include/assert.h:65:37: =E9=94=99=E8=AF=AF=EF=
=BC=9Aexpected declaration specifiers or =E2=80=98...=E2=80=99 before =E2=
=80=98CephContext=E2=80=99
>  extern void register_assert_context(CephContext *cct);
>                                      ^
> In file included from /root/code/ceph-12.1.0/src/crush/crush_compat.h:6:0=
,
>                  from /root/code/ceph-12.1.0/src/crush/crush.h:7,
>                  from /root/code/ceph-12.1.0/src/crush/builder.c:8:
> /root/code/ceph-12.1.0/src/crush/builder.c: =E5=9C=A8=E5=87=BD=E6=95=B0=
=E2=80=98crush_add_rule=E2=80=99=E4=B8=AD:
> /root/code/ceph-12.1.0/src/include/assert.h:118:6: =E9=94=99=E8=AF=AF=EF=
=BC=9A=E2=80=98static_cast=E2=80=99=E6=9C=AA=E5=A3=B0=E6=98=8E(=E5=9C=A8=E6=
=AD=A4=E5=87=BD=E6=95=B0=E5=86=85=E7=AC=AC=E4=B8=80=E6=AC=A1=E4=BD=BF=E7=94=
=A8)
>     ? static_cast<void> (0)    \
>       ^
> /root/code/ceph-12.1.0/src/crush/builder.c:75:3: =E9=99=84=E6=B3=A8=EF=BC=
=9Ain expansion of macro =E2=80=98assert=E2=80=99
>    assert(r < CRUSH_MAX_RULES);
>    ^
> /root/code/ceph-12.1.0/src/include/assert.h:118:6: =E9=99=84=E6=B3=A8=EF=
=BC=9A=E6=AF=8F=E4=B8=AA=E6=9C=AA=E5=A3=B0=E6=98=8E=E7=9A=84=E6=A0=87=E8=AF=
=86=E7=AC=A6=E5=9C=A8=E5=85=B6=E5=87=BA=E7=8E=B0=E7=9A=84=E5=87=BD=E6=95=B0=
=E5=86=85=E5=8F=AA=E6=8A=A5=E5=91=8A=E4=B8=80=E6=AC=A1
>     ? static_cast<void> (0)    \
>       ^
> /root/code/ceph-12.1.0/src/crush/builder.c:75:3: =E9=99=84=E6=B3=A8=EF=BC=
=9Ain expansion of macro =E2=80=98assert=E2=80=99
>    assert(r < CRUSH_MAX_RULES);
>    ^
> /root/code/ceph-12.1.0/src/include/assert.h:118:18: =E9=94=99=E8=AF=AF=EF=
=BC=9Aexpected expression before =E2=80=98void=E2=80=99
>     ? static_cast<void> (0)    \
>                   ^
> /root/code/ceph-12.1.0/src/crush/builder.c:75:3: =E9=99=84=E6=B3=A8=EF=BC=
=9Ain expansion of macro =E2=80=98assert=E2=80=99
>    assert(r < CRUSH_MAX_RULES);
>    ^
> /root/code/ceph-12.1.0/src/crush/builder.c: =E5=9C=A8=E5=87=BD=E6=95=B0=
=E2=80=98crush_rule_set_step=E2=80=99=E4=B8=AD:
> /root/code/ceph-12.1.0/src/include/assert.h:118:6: =E9=94=99=E8=AF=AF=EF=
=BC=9A=E2=80=98static_cast=E2=80=99=E6=9C=AA=E5=A3=B0=E6=98=8E(=E5=9C=A8=E6=
=AD=A4=E5=87=BD=E6=95=B0=E5=86=85=E7=AC=AC=E4=B8=80=E6=AC=A1=E4=BD=BF=E7=94=
=A8)
>     ? static_cast<void> (0)    \
>       ^
> /root/code/ceph-12.1.0/src/crush/builder.c:120:2: =E9=99=84=E6=B3=A8=EF=
=BC=9Ain expansion of macro =E2=80=98assert=E2=80=99
>   assert((__u32)n < rule->len);
>   ^
> /root/code/ceph-12.1.0/src/include/assert.h:118:18: =E9=94=99=E8=AF=AF=EF=
=BC=9Aexpected expression before =E2=80=98void=E2=80=99
>     ? static_cast<void> (0)    \
>                   ^
> /root/code/ceph-12.1.0/src/crush/builder.c:120:2: =E9=99=84=E6=B3=A8=EF=
=BC=9Ain expansion of macro =E2=80=98assert=E2=80=99
>   assert((__u32)n < rule->len);
>   ^
> /root/code/ceph-12.1.0/src/crush/builder.c: =E5=9C=A8=E5=87=BD=E6=95=B0=
=E2=80=98crush_remove_bucket=E2=80=99=E4=B8=AD:
> /root/code/ceph-12.1.0/src/include/assert.h:118:6: =E9=94=99=E8=AF=AF=EF=
=BC=9A=E2=80=98static_cast=E2=80=99=E6=9C=AA=E5=A3=B0=E6=98=8E(=E5=9C=A8=E6=
=AD=A4=E5=87=BD=E6=95=B0=E5=86=85=E7=AC=AC=E4=B8=80=E6=AC=A1=E4=BD=BF=E7=94=
=A8)
>     ? static_cast<void> (0)    \
>       ^
> /root/code/ceph-12.1.0/src/crush/builder.c:181:8: =E9=99=84=E6=B3=A8=EF=
=BC=9Ain expansion of macro =E2=80=98assert=E2=80=99
>         assert(pos < map->max_buckets);
>         ^
> /root/code/ceph-12.1.0/src/include/assert.h:118:18: =E9=94=99=E8=AF=AF=EF=
=BC=9Aexpected expression before =E2=80=98void=E2=80=99
>     ? static_cast<void> (0)    \
>                   ^
> /root/code/ceph-12.1.0/src/crush/builder.c:181:8: =E9=99=84=E6=B3=A8=EF=
=BC=9Ain expansion of macro =E2=80=98assert=E2=80=99
>         assert(pos < map->max_buckets);
>         ^
> /root/code/ceph-12.1.0/src/crush/builder.c: =E5=9C=A8=E5=87=BD=E6=95=B0=
=E2=80=98crush_make_tree_bucket=E2=80=99=E4=B8=AD:
> /root/code/ceph-12.1.0/src/include/assert.h:118:6: =E9=94=99=E8=AF=AF=EF=
=BC=9A=E2=80=98static_cast=E2=80=99=E6=9C=AA=E5=A3=B0=E6=98=8E(=E5=9C=A8=E6=
=AD=A4=E5=87=BD=E6=95=B0=E5=86=85=E7=AC=AC=E4=B8=80=E6=AC=A1=E4=BD=BF=E7=94=
=A8)
>     ? static_cast<void> (0)    \
>       ^
> /root/code/ceph-12.1.0/src/crush/builder.c:13:19: =E9=99=84=E6=B3=A8=EF=
=BC=9Ain expansion of macro =E2=80=98assert=E2=80=99
>  #define BUG_ON(x) assert(!(x))
>                    ^
> /root/code/ceph-12.1.0/src/crush/builder.c:386:2: =E9=99=84=E6=B3=A8=EF=
=BC=9Ain expansion of macro =E2=80=98BUG_ON=E2=80=99
>   BUG_ON(bucket->node_weights[bucket->num_nodes/2] !=3D bucket->h.weight)=
;
>   ^
> /root/code/ceph-12.1.0/src/include/assert.h:118:18: =E9=94=99=E8=AF=AF=EF=
=BC=9Aexpected expression before =E2=80=98void=E2=80=99
>     ? static_cast<void> (0)    \
>                   ^
> /root/code/ceph-12.1.0/src/crush/builder.c:13:19: =E9=99=84=E6=B3=A8=EF=
=BC=9Ain expansion of macro =E2=80=98assert=E2=80=99
>  #define BUG_ON(x) assert(!(x))
>                    ^
> /root/code/ceph-12.1.0/src/crush/builder.c:386:2: =E9=99=84=E6=B3=A8=EF=
=BC=9Ain expansion of macro =E2=80=98BUG_ON=E2=80=99
>   BUG_ON(bucket->node_weights[bucket->num_nodes/2] !=3D bucket->h.weight)=
;
>   ^
> /root/code/ceph-12.1.0/src/crush/builder.c: =E5=9C=A8=E5=87=BD=E6=95=B0=
=E2=80=98crush_make_choose_args=E2=80=99=E4=B8=AD:
> /root/code/ceph-12.1.0/src/include/assert.h:118:6: =E9=94=99=E8=AF=AF=EF=
=BC=9A=E2=80=98static_cast=E2=80=99=E6=9C=AA=E5=A3=B0=E6=98=8E(=E5=9C=A8=E6=
=AD=A4=E5=87=BD=E6=95=B0=E5=86=85=E7=AC=AC=E4=B8=80=E6=AC=A1=E4=BD=BF=E7=94=
=A8)
>     ? static_cast<void> (0)    \
>       ^
> /root/code/ceph-12.1.0/src/crush/builder.c:13:19: =E9=99=84=E6=B3=A8=EF=
=BC=9Ain expansion of macro =E2=80=98assert=E2=80=99
>  #define BUG_ON(x) assert(!(x))
>                    ^
> /root/code/ceph-12.1.0/src/crush/builder.c:1425:3: =E9=99=84=E6=B3=A8=EF=
=BC=9Ain expansion of macro =E2=80=98BUG_ON=E2=80=99
>    BUG_ON(space + size !=3D ids_end);
>    ^
> /root/code/ceph-12.1.0/src/include/assert.h:118:18: =E9=94=99=E8=AF=AF=EF=
=BC=9Aexpected expression before =E2=80=98void=E2=80=99
>     ? static_cast<void> (0)    \
>                   ^
> /root/code/ceph-12.1.0/src/crush/builder.c:13:19: =E9=99=84=E6=B3=A8=EF=
=BC=9Ain expansion of macro =E2=80=98assert=E2=80=99
>  #define BUG_ON(x) assert(!(x))
>                    ^
> /root/code/ceph-12.1.0/src/crush/builder.c:1425:3: =E9=99=84=E6=B3=A8=EF=
=BC=9Ain expansion of macro =E2=80=98BUG_ON=E2=80=99
>    BUG_ON(space + size !=3D ids_end);
>    ^
> /root/code/ceph-12.1.0/src/include/assert.h:118:18: =E9=94=99=E8=AF=AF=EF=
=BC=9Aexpected expression before =E2=80=98void=E2=80=99
>     ? static_cast<void> (0)    \
>                   ^
> /root/code/ceph-12.1.0/src/crush/builder.c:13:19: =E9=99=84=E6=B3=A8=EF=
=BC=9Ain expansion of macro =E2=80=98assert=E2=80=99
>  #define BUG_ON(x) assert(!(x))
>                    ^
> /root/code/ceph-12.1.0/src/crush/builder.c:1450:3: =E9=99=84=E6=B3=A8=EF=
=BC=9Ain expansion of macro =E2=80=98BUG_ON=E2=80=99
>    BUG_ON((char*)weight_set_ends !=3D (char*)weight_set);
>    ^
> /root/code/ceph-12.1.0/src/include/assert.h:118:18: =E9=94=99=E8=AF=AF=EF=
=BC=9Aexpected expression before =E2=80=98void=E2=80=99
>     ? static_cast<void> (0)    \
>                   ^
> /root/code/ceph-12.1.0/src/crush/builder.c:13:19: =E9=99=84=E6=B3=A8=EF=
=BC=9Ain expansion of macro =E2=80=98assert=E2=80=99
>  #define BUG_ON(x) assert(!(x))
>                    ^
> /root/code/ceph-12.1.0/src/crush/builder.c:1451:3: =E9=99=84=E6=B3=A8=EF=
=BC=9Ain expansion of macro =E2=80=98BUG_ON=E2=80=99
>    BUG_ON((char*)weights_end !=3D (char*)weights);
>    ^
> /root/code/ceph-12.1.0/src/include/assert.h:118:18: =E9=94=99=E8=AF=AF=EF=
=BC=9Aexpected expression before =E2=80=98void=E2=80=99
>     ? static_cast<void> (0)    \
>                   ^
> /root/code/ceph-12.1.0/src/crush/builder.c:13:19: =E9=99=84=E6=B3=A8=EF=
=BC=9Ain expansion of macro =E2=80=98assert=E2=80=99
>  #define BUG_ON(x) assert(!(x))
>                    ^
> /root/code/ceph-12.1.0/src/crush/builder.c:1452:3: =E9=99=84=E6=B3=A8=EF=
=BC=9Ain expansion of macro =E2=80=98BUG_ON=E2=80=99
>    BUG_ON((char*)ids !=3D (char*)ids_end);
>    ^
> make[2]: *** [src/CMakeFiles/crush_objs.dir/crush/builder.c.o] =E9=94=99=
=E8=AF=AF 1
> make[1]: *** [src/CMakeFiles/crush_objs.dir/all] =E9=94=99=E8=AF=AF 2
> make: *** [all] =E9=94=99=E8=AF=AF 2
>
> Who can tell me how to resolve the problem. Thanks
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Regards
Kefu Chai
