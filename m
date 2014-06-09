From: Zack Cerza <zack.cerza@inktank.com>
Subject: Re: teuthology and erasure code pool creation
Date: Mon, 9 Jun 2014 12:15:00 -0500
Message-ID: <CAMfdg1PhTWuL1LKCZuOV5GwhNMehsY1HNeBPtWkJwy01_7Q42g@mail.gmail.com>
References: <539488A3.3070507@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:41780 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754873AbaFIRPA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jun 2014 13:15:00 -0400
Received: by mail-yk0-f178.google.com with SMTP id q9so699298ykb.37
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jun 2014 10:15:00 -0700 (PDT)
In-Reply-To: <539488A3.3070507@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,

Without spending too much time investigating, it seems to me it would
be preferable to just add the missing arguments to the functions you
pointed out. That way they could even be fully documented! ;)

Zack

On Sun, Jun 8, 2014 at 11:00 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Zack,
>
> In order to test locally repairable codes ( described at https://wiki=
=2Eceph.com/Planning/Blueprints/Giant/Pyramid_Erasure_Code and document=
ed at https://github.com/dachary/ceph/commit/2ae645438243232392c11fd80f=
d960f6221fd2a0#diff-5518964bc98a094a784ce2d17a5b0cc1R20 ) it would be a=
 convenient to set the erasure code profile without modifying the teuth=
ology code.
>
> There are not too many instances of hardcoded parameters:
>
>   https://github.com/ceph/teuthology/blob/master/teuthology/task_util=
/rados.py#L27
>   https://github.com/ceph/teuthology/blob/master/teuthology/task/ceph=
_manager.py#L732
>
> and it could be generalized. In a nutshell, the definition of an eras=
ure coded profile is a set of key value which should default to:
>
>   k: 2
>   m: 1
>   plugin: jerasure
>   ruleset-failure-domain: osd
>
> and
>
>   self.raw_cluster_cmd('osd', 'erasure-code-profile', 'set', 'teuthol=
ogyprofile', 'ruleset-failure-domain=3Dosd', 'm=3D'+str(ec_m), 'k=3D'+s=
tr(ec_k))
>
> could be replaced with:
>
>    self.raw_cluster_cmd('osd', 'erasure-code-profile', 'set', 'teutho=
logyprofile', **kwargs)
>
> assuming kwargs is the above map parsed from the yaml.
>
> Any advice you may have on the implementation would be very welcome :=
-)
>
> Cheers
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
