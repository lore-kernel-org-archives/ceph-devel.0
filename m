From: Samuel Just <sam.just@inktank.com>
Subject: Re: caching get_chunk_size()
Date: Sun, 2 Feb 2014 14:28:52 -0800
Message-ID: <CA+4uBUYFdHQEf40-s137MnS7fFA52ddqJL_714xW0C-4yQtyQA@mail.gmail.com>
References: <52EE5EE6.7010904@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:45560 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbaBBW2w convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 2 Feb 2014 17:28:52 -0500
Received: by mail-qc0-f171.google.com with SMTP id n7so10082554qcx.16
        for <ceph-devel@vger.kernel.org>; Sun, 02 Feb 2014 14:28:52 -0800 (PST)
In-Reply-To: <52EE5EE6.7010904@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

That looks about right to me.  It's handy to have a "ground truth" for
everyone to ensure that they agree with.
-Sam

On Sun, Feb 2, 2014 at 7:06 AM, Loic Dachary <loic@dachary.org> wrote:
> [cc' ceph-devel]
>
> Hi Sam,
>
> Assuming https://github.com/ceph/ceph/pull/1144 gets merged, MONs can=
 query the plugin for a given pool or crush ruleset conveniently:
>
> https://github.com/dachary/ceph/blob/15c90fbf61445063967fc80ee1c916d7=
0c593a54/src/mon/OSDMonitor.cc#L2803
>
>       ErasureCodeInterfaceRef erasure_code;
>       err =3D get_erasure_code(properties, &erasure_code, ss);
>       if (err =3D=3D 0)
>          *size =3D erasure_code->get_chunk_count();
>
> And OSDs can do something similar (and must whenever an erasure coded=
 pool is instantiated). If I understood correctly, you would like the r=
esult of erasure_code->get_chunk_size(some_osd_config_opt_value_definin=
g_the_stripe_size) to be set as a new value in pg_pool_t https://github=
=2Ecom/dachary/ceph/blob/15c90fbf61445063967fc80ee1c916d70c593a54/src/o=
sd/osd_types.h#L700 when the pool is created.
>
> The benefit of having pg_pool_t::chunk_size would be
>
> a) the value is shared cluster wide and does not depend on the specif=
ic version of the OSD/MON
> b) if the value is needed frequently in a context where the plugin wo=
uld have to be loaded, this will improve performances
>
> However, whenever an OSD instantiates a PG that belongs to a pool, it=
 must assert that the get_chunk_count() returned by the plugin matches =
the value stored in pg_pool_t::chunk_size otherwise it will encode inco=
nsistently.
>
> If my reasoning matches yours, I'll implement the change. Otherwise, =
please correct me :-)
>
> Cheers
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
