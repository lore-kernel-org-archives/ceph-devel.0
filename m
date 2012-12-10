From: Samuel Just <sam.just@inktank.com>
Subject: Re: Few questions about Ceph
Date: Mon, 10 Dec 2012 14:31:17 -0800
Message-ID: <CA+4uBUZPTAvaeGMuNDm04mGykfdzvZYFnvd738J7Hw+aTZ5Rcw@mail.gmail.com>
References: <CAGBmBz-CWSZM_QB9k+MG71VZzLV94VG7xhBaemPZqfqj1F2L4g@mail.gmail.com>
	<CA+4uBUYEd1ceHvLHG5U77YWB4XTc=xgDOKP1a07CJUnsTytYAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:50873 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab2LJWbS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Dec 2012 17:31:18 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so2993552vcd.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Dec 2012 14:31:17 -0800 (PST)
In-Reply-To: <CA+4uBUYEd1ceHvLHG5U77YWB4XTc=xgDOKP1a07CJUnsTytYAQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Alexandre_Maumen=E9?= <alexandre@maumene.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

oops, ssd-primary should be ruleset 5
-Sam

On Mon, Dec 10, 2012 at 2:22 PM, Samuel Just <sam.just@inktank.com> wro=
te:
> 3) Forgive the style, it'll be going into the docs shortly :)
>
> It's possible to have multiple independent crush heirarchies within t=
he same
> crush map.  Suppose you want to have pools default to osds backed by =
large
> spinning disks but have some pools mapped to osds backed by fast ssds=
:
>
>   device 0 osd.0
>   device 1 osd.1
>   device 2 osd.2
>   device 3 osd.3
>   device 4 osd.4
>   device 5 osd.5
>   device 6 osd.6
>   device 7 osd.7
>
>        host ceph-osd-ssd-server-1 {
>                id -1
>                alg straw
>                hash 0
>                item osd.0 weight 1.00
>                item osd.1 weight 1.00
>        }
>
>        host ceph-osd-ssd-server-2 {
>                id -2
>                alg straw
>                hash 0
>                item osd.2 weight 1.00
>                item osd.3 weight 1.00
>        }
>
>        host ceph-osd-platter-server-1 {
>                id -3
>                alg straw
>                hash 0
>                item osd.4 weight 1.00
>                item osd.5 weight 1.00
>        }
>
>        host ceph-osd-platter-server-2 {
>                id -4
>                alg straw
>                hash 0
>                item osd.6 weight 1.00
>                item osd.7 weight 1.00
>        }
>
>        root platter {
>                id -5
>                alg straw
>                hash 0
>                item ceph-osd-platter-server-1 weight 2.00
>                item ceph-osd-platter-server-2 weight 2.00
>        }
>
>        root ssd {
>                id -6
>                alg straw
>                hash 0
>                item ceph-osd-ssd-server-1 weight 2.00
>                item ceph-osd-ssd-server-2 weight 2.00
>        }
>
>        rule data {
>                ruleset 0
>                type replicated
>                min_size 2
>                max_size 2
>                step take platter
>                step chooseleaf 0 type host
>                step emit
>        }
>
>        rule metadata {
>                ruleset 1
>                type replicated
>                min_size 0
>                max_size 10
>                step take platter
>                step chooseleaf 0 type host
>                step emit
>        }
>
>        rule rbd {
>                ruleset 2
>                type replicated
>                min_size 0
>                max_size 10
>                step take platter
>                step chooseleaf 0 type host
>                step emit
>        }
>
>        rule platter {
>                ruleset 3
>                type replicated
>                min_size 0
>                max_size 10
>                step take platter
>                step chooseleaf 0 type host
>                step emit
>        }
>
>        rule ssd {
>                ruleset 4
>                type replicated
>                min_size 0
>                max_size 10
>                step take ssd
>                step chooseleaf 0 type host
>                step emit
>        }
>
>        rule ssd-primary {
>                ruleset 4
>                type replicated
>                min_size 0
>                max_size 10
>                step take ssd
>                step chooseleaf 1 type host
>                step emit
>                step take platter
>                step chooseleaf -1 type host
>                step emit
>        }
>
> You can then set a pool to use the ssd rule by:
> ceph osd pool set <poolname> crush_ruleset 4
>
> Similarly, using the ssd-primary rule will cause
> each pg in the pool to be placed with an ssd as
> the primary and platters as the replicas.
>
> -Sam
>
> On Mon, Dec 10, 2012 at 11:17 AM, Alexandre Maumen=E9
> <alexandre@maumene.org> wrote:
>> Hello all,
>>
>> I have a few questions about Ceph:
>>
>> 1) Is it possible to run a cluster with "some" lantecy between monit=
or
>> nodes? Latency will be 30ms at worst.
>>
>> 2) When using RBD what are the best practices for a direct mount usi=
ng
>> XFS filesystem? And for a qemu/kvm devices? I'm thinking about
>> writeback, rbd_cache, ...
>>
>> 3) About the CRUSH map, how can I separate 2 pools on different OSD?
>> I'd like to setup a cluster with different disks (like SATA/SAS) and=
 I
>> want to be able to specify on which disks (or OSD) my data are going
>> to be write.
>>
>> Thanks in advance for any answer.
>>
>> Regards,
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
