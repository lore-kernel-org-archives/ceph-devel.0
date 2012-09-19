From: Tren Blackburn <tren@eotnetworks.com>
Subject: Re: Memory usage of ceph-mds
Date: Wed, 19 Sep 2012 14:05:14 -0700
Message-ID: <CANLRBoyKVk68Kxd85++WjWFr4870ihrRqWarO69V+7Pza62mXw@mail.gmail.com>
References: <CANLRBoyZ5JCTfdu_ntf+aOYBPa2C4w5TLM8-2Q4_=YWg8=VL1w@mail.gmail.com>
	<alpine.DEB.2.00.1209191347210.7537@cobra.newdream.net>
	<CAPYLRziPh0+7BGxMa7e9n6QQGruRX6-58x-fnAAwYaONkOVZ1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:48462 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab2ISVFP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Sep 2012 17:05:15 -0400
Received: by vbbff1 with SMTP id ff1so1809251vbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 19 Sep 2012 14:05:15 -0700 (PDT)
In-Reply-To: <CAPYLRziPh0+7BGxMa7e9n6QQGruRX6-58x-fnAAwYaONkOVZ1g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On Wed, Sep 19, 2012 at 1:52 PM, Gregory Farnum <greg@inktank.com> wrot=
e:
> On Wed, Sep 19, 2012 at 1:48 PM, Sage Weil <sage@inktank.com> wrote:
>> On Wed, 19 Sep 2012, Tren Blackburn wrote:
>>> Hey List;
>>>
>>> I'm in the process of rsyncing in about 7TB of data to Ceph across
>>> approximately 58565475 files (okay, so I guess that's not so
>>> approximate). It's only managed to copy a small portion of this so =
far
>>> (about 35GB) and the server that currently is the mds master shows =
the
>>> ceph-mds process closing in on 2GB of RAM used. I'm getting a littl=
e
>>> nervous about this steep increase.
>>>
>>> fern ceph # ps wwaux | grep ceph-mds
>>> root     29943  3.7  0.9 2473884 1915468 ?     Ssl  08:42  11:22
>>> /usr/bin/ceph-mds -i 1 --pid-file /var/run/ceph/mds.1.pid -c
>>> /etc/ceph/ceph.conf
>>>
>>> Thank in advance!
>>
>> That's not necessarily a problem.  The mds memory usage is controlle=
d via
>> the 'mds cache size' knob which defaults to 100,000.  You might try
>> halving that and restarting the MDS.
>
> Last time we counted those inodes were ~1KB each, so getting 2GB of
> memory used is an awful lot.
>
> Tren, what does your tree look like =97 are there very large director=
ies?

Greg: It's difficult to tell you that. I'm rsyncing 2 volumes from our
filers. Each base directory on each filer mount has approximate 213
directories, and then each directory under that has approximately
anywhere from 3000 - 5000 directories (very loose approximation here,
850,000 directories per filer mount), and then each of those
directories contains files.

We have many many files here. We're doing this to see how CephFS
handles lots of files. We are coming from MooseFS which its master
metalogger process eats lots of ram, so we're hoping that Ceph is a
bit lighter on us.

Sage: The memory the MDS is using is only a cache? There should be no
problem restarting the MDS server while activity is going on? I should
probably change the limit for the non-active MDS servers first, and
then the active one and hope it fails over cleanly?

Thank you both for your assistance!

t.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
