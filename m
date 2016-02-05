From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: upgrade/infernalis 26 jobs vs 10 jobs
Date: Fri, 5 Feb 2016 08:35:47 -0800
Message-ID: <CAMMFjmGPDQLkoTXUaAo4kho7-=JR6V3PA9dGXAp_aREZZXB0Qw@mail.gmail.com>
References: <56B44C13.9080708@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:38618 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754413AbcBEQfs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Feb 2016 11:35:48 -0500
Received: by mail-ig0-f182.google.com with SMTP id mw1so17299772igb.1
        for <ceph-devel@vger.kernel.org>; Fri, 05 Feb 2016 08:35:47 -0800 (PST)
In-Reply-To: <56B44C13.9080708@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Loic,

crontab is here
http://tracker.ceph.com/projects/ceph-releases/wiki/Sepia as always :)
cli teuthology-suite -v -c infernalis -k distro -m vps -s
upgrade/infernalis ~/vps.yaml --dry-run

Your count is correct as per PR
https://github.com/ceph/ceph-qa-suite/pull/799 I added + to reduce
numer of jobs (in upgrade/infernalis/older/2-workload/+)

Thx
YuriW

On Thu, Feb 4, 2016 at 11:15 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Yuri,
>
> When running teuthology-suite --verbose --suite upgrade/infernalis --=
suite-branch infernalis --ceph infernalis --machine-type vps --priority=
 1000 --dry-run it shows 10 jobs:
>
> 2016-02-05 14:13:26,673.673 INFO:teuthology.suite:Suite upgrade:infer=
nalis in /home/loic/src/ceph-qa-suite_infernalis/suites/upgrade/inferna=
lis scheduled 10 jobs.
>
> however, looking at http://pulpito.ceph.com/?branch=3Dinfernalis&suit=
e=3Dupgrade%3Ainfernalis shows each run has 26 jobs. Would you be so ki=
nd as to let me know the command line you're using to get that result ?
>
> Thanks in advance :-)
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
