From: sheng qiu <herbert1984106@gmail.com>
Subject: Re: ceph mkfs failed
Date: Fri, 8 Feb 2013 11:07:27 -0600
Message-ID: <CAB7xdinp4=R6AXnoGwxLP+O9=_fSbhNgJQCN8b+ywn=pFk7Eow@mail.gmail.com>
References: <CAB7xdi=5q-e7FEXjrf524as4FPW-pM4z9wDrCm7boPVTr7sVLg@mail.gmail.com>
	<51140CFF.8000207@inktank.com>
	<CAB7xdimctzpk8qeRLJqxxeNRJEFpc2EpVHd37qj0E-OCeBP13A@mail.gmail.com>
	<CAPYLRzjeNZn+aYwtcij0YddYX=Fpd=xY5+QrveaNNMXCL4bLUw@mail.gmail.com>
	<CAB7xdin+Ow_KE1EgNSK6PG4EDSKgO=DSjFJBpBVKjL-Rd5wehA@mail.gmail.com>
	<511428FA.3040209@inktank.com>
	<CAB7xdikEyH0_4TsFiabRmQXRkTs=vtJe1njtc4QpWq1sMANAHQ@mail.gmail.com>
	<CAB7xdi=tnmU3jWVfmLjxSFa_kdNrPbcd=3uePUaJ0k-S5gyMfQ@mail.gmail.com>
	<alpine.DEB.2.00.1302080902030.18035@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:47845 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946749Ab3BHRH1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 12:07:27 -0500
Received: by mail-ia0-f179.google.com with SMTP id x24so4379075iak.38
        for <ceph-devel@vger.kernel.org>; Fri, 08 Feb 2013 09:07:27 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1302080902030.18035@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Dan Mick <dan.mick@inktank.com>, Gregory Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage,

it's a memory based fs similar to pramfs.

Thanks,
Sheng

On Fri, Feb 8, 2013 at 11:02 AM, Sage Weil <sage@inktank.com> wrote:
> Hi Sheng-
>
> On Fri, 8 Feb 2013, sheng qiu wrote:
>> least pass through the init-ceph script). i made a minor change on
>> ceph code, i changed the link_object() in LFNIndex.cc, basically i
>> changed the hard link call ::link() to symlink(), as my local fs does
>> not support hard link (the directory entry stores together with the
>> related inodes).
>
> Unrelated question: which local fs are you using?
>
> sage



-- 
Sheng Qiu
Texas A & M University
Room 332B Wisenbaker
email: herbert1984106@gmail.com
College Station, TX 77843-3259
