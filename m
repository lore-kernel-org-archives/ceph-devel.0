From: David Zafman <dzafman@redhat.com>
Subject: Re: teuthology-suite argument puzzle
Date: Thu, 13 Oct 2016 09:14:56 -0700
Message-ID: <0ff53e69-64f2-bb73-11dc-111f9e638232@redhat.com>
References: <57FF8326.4040209@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754068AbcJMQZA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 13 Oct 2016 12:25:00 -0400
In-Reply-To: <57FF8326.4040209@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Zack Cerza <zack@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


I was trying --rereun today too.  I do know that you wanted to eliminate 
the --suite option.  But I have 10 failed jobs, but a --dry-run said it 
would have only scheduled 1 job.

David

On 10/13/16 5:50 AM, Loic Dachary wrote:
> Hi Zack,
>
> I wanted to try --rerun and ran into a cryptic error message:
>
> run=loic-2016-10-13_09:20:07-rgw-jewel-backports-distro-basic-smithi
> teuthology-suite -k distro --priority 101 --suite rgw --rerun $run --suite-branch jewel --email loic@dachary.org --ceph jewel-backports --machine-type smithi
> usage: teuthology-suite --help
>         teuthology-suite [-v | -vv ] --suite <suite> [options] [<config_yaml>...]
>         teuthology-suite [-v | -vv ] --rerun <name>  [options] [<config_yaml>...]
>
> What did I do wrong ?
>
> Cheers

