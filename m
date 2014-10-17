From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: vstart.sh crashes MON with --paxos-propose-interval=0.01 and
 one MDS
Date: Fri, 17 Oct 2014 12:18:36 +0100
Message-ID: <5440FB0C.5080205@inktank.com>
References: <54404C3F.4030904@dachary.org> <734FCEB2-7161-4B6E-8886-9BC0126D997F@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:54992 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbaJQLSf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Oct 2014 07:18:35 -0400
Received: by mail-wg0-f52.google.com with SMTP id a1so671974wgh.11
        for <ceph-devel@vger.kernel.org>; Fri, 17 Oct 2014 04:18:33 -0700 (PDT)
In-Reply-To: <734FCEB2-7161-4B6E-8886-9BC0126D997F@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <david.zafman@inktank.com>, Loic Dachary <loic@dachary.org>
Cc: John Spray <john.spray@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 10/17/2014 03:42 AM, David Zafman wrote:
>
> I have this change in my branch so that test/ceph_objectstore_tool.py=
 works again after that change from John.  I wonder if this would fix y=
our case too:
>
> commit 18937cf49be616d32b4e2d0b6deef2882321fbe4
> Author: David Zafman <dzafman@redhat.com>
> Date:   Tue Oct 14 18:45:41 2014 -0700
>
>      vstart.sh: Disable "mon pg warn min per osd" to get healthy
>
>      Signed-off-by: David Zafman <dzafman@redhat.com>
>
> diff --git a/src/vstart.sh b/src/vstart.sh
> index febfa56..7a0ec1c 100755
> --- a/src/vstart.sh
> +++ b/src/vstart.sh
> @@ -394,7 +394,7 @@ $COSDDEBUG
>   $COSDMEMSTORE
>   $extra_conf
>   [mon]
> -        mon pg warn min per osd =3D 10
> +        mon pg warn min per osd =3D 0
>           mon osd allow primary affinity =3D true
>           mon reweight min pgs per osd =3D 4
>   $DAEMONOPTS
>

Even if that fixes the issue you're seeing, that is nothing but a=20
band-aid.  I've tracked down the issue Loic is seeing a few days ago an=
d=20
it is sitting in wip-9321.giant=20
(c84a13ae87eed5550bafda394d983a8e843cc08c).  I though it was due to an=20
earlier patch of mine on the same branch but now I see the issue can po=
p=20
up regardless of my patch, which is a good thing as it as it doesn't=20
mean we really have to wait until that branch clears up the suite to=20
merge but simply current master with this patch applied.

I've updated #9794 with this information.

   -Joao



> David Zafman
> Senior Developer
> http://www.inktank.com
>
>
>
>
> On Oct 16, 2014, at 3:52 PM, Loic Dachary <loic@dachary.org> wrote:
>
>> Hi John,
>>
>> I would be gratefull if you could take a quick look at http://tracke=
r.ceph.com/issues/9794 . It is bisected to the reduction of pg and I'm =
able to reproduce it in a ubuntu-14.04 docker fresh install. For some r=
eason it does not happen in gitbuilder but I think you can reproduce it=
 locally now.
>>
>> Cheers
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--=20
Joao Eduardo Luis
Software Engineer | http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
