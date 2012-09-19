From: Tren Blackburn <tren@eotnetworks.com>
Subject: Re: Memory usage of ceph-mds
Date: Wed, 19 Sep 2012 14:21:10 -0700
Message-ID: <CANLRBoyfwajKToDqWgnfMWK9b8AAGX3WsRW9Ymr-96GsqTJ1ag@mail.gmail.com>
References: <CANLRBoyZ5JCTfdu_ntf+aOYBPa2C4w5TLM8-2Q4_=YWg8=VL1w@mail.gmail.com>
	<alpine.DEB.2.00.1209191347210.7537@cobra.newdream.net>
	<CAPYLRziPh0+7BGxMa7e9n6QQGruRX6-58x-fnAAwYaONkOVZ1g@mail.gmail.com>
	<CANLRBoyKVk68Kxd85++WjWFr4870ihrRqWarO69V+7Pza62mXw@mail.gmail.com>
	<CAPYLRziJNqjZnD4J8ufhMZ+GYs3Wn67Qk_=GJKsb45e_D8Qjgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:63084 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787Ab2ISVVK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Sep 2012 17:21:10 -0400
Received: by vcbfo13 with SMTP id fo13so1785222vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 19 Sep 2012 14:21:10 -0700 (PDT)
In-Reply-To: <CAPYLRziJNqjZnD4J8ufhMZ+GYs3Wn67Qk_=GJKsb45e_D8Qjgw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On Wed, Sep 19, 2012 at 2:12 PM, Gregory Farnum <greg@inktank.com> wrot=
e:
> On Wed, Sep 19, 2012 at 2:05 PM, Tren Blackburn <tren@eotnetworks.com=
> wrote:
>
>> Greg: It's difficult to tell you that. I'm rsyncing 2 volumes from o=
ur
>> filers. Each base directory on each filer mount has approximate 213
>> directories, and then each directory under that has approximately
>> anywhere from 3000 - 5000 directories (very loose approximation here=
,
>> 850,000 directories per filer mount), and then each of those
>> directories contains files.
>
> Ah, directories are larger =97 Sage, do you think they're enough bigg=
er
> to make up that much extra memory usage?
>
>
>> We have many many files here. We're doing this to see how CephFS
>> handles lots of files. We are coming from MooseFS which its master
>> metalogger process eats lots of ram, so we're hoping that Ceph is a
>> bit lighter on us.
>>
>> Sage: The memory the MDS is using is only a cache? There should be n=
o
>> problem restarting the MDS server while activity is going on? I shou=
ld
>> probably change the limit for the non-active MDS servers first, and
>> then the active one and hope it fails over cleanly?
> Yep, that should work fine, with the obvious caveat that your
> filesystem will become inaccessible if the MDS is down long enough fo=
r
> clients to exceed their timeouts (no metadata loss though, if all
> clients remain active until the MDS comes back up).

I have 3 MDS's (active/standby setup). Shouldn't the MDS fail over to
the other node when I restart the process? I'm not sure what the best
method for just restarting the MDS is, and can it be done without
forcing a fail over?

t.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
