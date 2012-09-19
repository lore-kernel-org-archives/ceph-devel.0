From: Gregory Farnum <greg@inktank.com>
Subject: Re: Memory usage of ceph-mds
Date: Wed, 19 Sep 2012 13:52:09 -0700
Message-ID: <CAPYLRziPh0+7BGxMa7e9n6QQGruRX6-58x-fnAAwYaONkOVZ1g@mail.gmail.com>
References: <CANLRBoyZ5JCTfdu_ntf+aOYBPa2C4w5TLM8-2Q4_=YWg8=VL1w@mail.gmail.com>
	<alpine.DEB.2.00.1209191347210.7537@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:53166 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab2ISUwK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Sep 2012 16:52:10 -0400
Received: by ieak13 with SMTP id k13so2243006iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 19 Sep 2012 13:52:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1209191347210.7537@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Tren Blackburn <tren@eotnetworks.com>, ceph-devel@vger.kernel.org

On Wed, Sep 19, 2012 at 1:48 PM, Sage Weil <sage@inktank.com> wrote:
> On Wed, 19 Sep 2012, Tren Blackburn wrote:
>> Hey List;
>>
>> I'm in the process of rsyncing in about 7TB of data to Ceph across
>> approximately 58565475 files (okay, so I guess that's not so
>> approximate). It's only managed to copy a small portion of this so f=
ar
>> (about 35GB) and the server that currently is the mds master shows t=
he
>> ceph-mds process closing in on 2GB of RAM used. I'm getting a little
>> nervous about this steep increase.
>>
>> fern ceph # ps wwaux | grep ceph-mds
>> root     29943  3.7  0.9 2473884 1915468 ?     Ssl  08:42  11:22
>> /usr/bin/ceph-mds -i 1 --pid-file /var/run/ceph/mds.1.pid -c
>> /etc/ceph/ceph.conf
>>
>> Thank in advance!
>
> That's not necessarily a problem.  The mds memory usage is controlled=
 via
> the 'mds cache size' knob which defaults to 100,000.  You might try
> halving that and restarting the MDS.

Last time we counted those inodes were ~1KB each, so getting 2GB of
memory used is an awful lot.

Tren, what does your tree look like =97 are there very large directorie=
s?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
