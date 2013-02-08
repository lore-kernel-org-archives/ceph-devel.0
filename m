From: Sage Weil <sage@inktank.com>
Subject: Re: ceph mkfs failed
Date: Fri, 8 Feb 2013 09:02:37 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302080902030.18035@cobra.newdream.net>
References: <CAB7xdi=5q-e7FEXjrf524as4FPW-pM4z9wDrCm7boPVTr7sVLg@mail.gmail.com> <51140CFF.8000207@inktank.com> <CAB7xdimctzpk8qeRLJqxxeNRJEFpc2EpVHd37qj0E-OCeBP13A@mail.gmail.com> <CAPYLRzjeNZn+aYwtcij0YddYX=Fpd=xY5+QrveaNNMXCL4bLUw@mail.gmail.com>
 <CAB7xdin+Ow_KE1EgNSK6PG4EDSKgO=DSjFJBpBVKjL-Rd5wehA@mail.gmail.com> <511428FA.3040209@inktank.com> <CAB7xdikEyH0_4TsFiabRmQXRkTs=vtJe1njtc4QpWq1sMANAHQ@mail.gmail.com> <CAB7xdi=tnmU3jWVfmLjxSFa_kdNrPbcd=3uePUaJ0k-S5gyMfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40769 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758581Ab3BHRCh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 12:02:37 -0500
In-Reply-To: <CAB7xdi=tnmU3jWVfmLjxSFa_kdNrPbcd=3uePUaJ0k-S5gyMfQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: Dan Mick <dan.mick@inktank.com>, Gregory Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Sheng-

On Fri, 8 Feb 2013, sheng qiu wrote:
> least pass through the init-ceph script). i made a minor change on
> ceph code, i changed the link_object() in LFNIndex.cc, basically i
> changed the hard link call ::link() to symlink(), as my local fs does
> not support hard link (the directory entry stores together with the
> related inodes).

Unrelated question: which local fs are you using?

sage
