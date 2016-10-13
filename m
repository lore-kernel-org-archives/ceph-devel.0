From: Loic Dachary <loic@dachary.org>
Subject: Re: teuthology-suite argument puzzle
Date: Thu, 13 Oct 2016 16:29:50 +0200
Message-ID: <57FF9A5E.7080106@dachary.org>
References: <57FF8326.4040209@dachary.org>
 <CAOi1vP-QpF=0GLVUq_VScGhU7jJnmFUZUSSHXMWkOY4uvPfM2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:57511 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbcJMOaM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Oct 2016 10:30:12 -0400
In-Reply-To: <CAOi1vP-QpF=0GLVUq_VScGhU7jJnmFUZUSSHXMWkOY4uvPfM2w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Zack Cerza <zack@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>



On 13/10/2016 14:56, Ilya Dryomov wrote:
> On Thu, Oct 13, 2016 at 2:50 PM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Zack,
>>
>> I wanted to try --rerun and ran into a cryptic error message:
>>
>> run=loic-2016-10-13_09:20:07-rgw-jewel-backports-distro-basic-smithi
>> teuthology-suite -k distro --priority 101 --suite rgw --rerun $run --suite-branch jewel --email loic@dachary.org --ceph jewel-backports --machine-type smithi
>> usage: teuthology-suite --help
>>        teuthology-suite [-v | -vv ] --suite <suite> [options] [<config_yaml>...]
>>        teuthology-suite [-v | -vv ] --rerun <name>  [options] [<config_yaml>...]
>>
>> What did I do wrong ?
> 
> Try w/o the --suite?  Just guessing - --suite gets inherited on --rerun.

It does work, I'm impressed by your guessing skills :-)

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
