From: Christopher Kunz <chrislist@de-punkt.de>
Subject: Re: 0.56 scrub OSD memleaks, WAS Re: [0.48.3] OSD memory leak when
 scrubbing
Date: Tue, 19 Feb 2013 20:50:41 +0100
Message-ID: <5123D791.9000407@de-punkt.de>
References: <CAF6-1L5Evp-vz1K4M9tu4vVLfbBzXfgL4+GHBGzGjZJ-KoPt3A@mail.gmail.com> <alpine.DEB.2.00.1301301139490.18801@cobra.newdream.net> <CAF6-1L5z39ZsPwBz5yJWDvQoX7UaUZ5PVpUwfVhoBne56Z018Q@mail.gmail.com> <alpine.DEB.2.00.1301311141240.807@cobra.newdream.net> <510EA9A1.6070505@dachary.org> <CAOLwVUkUFvLihb6KbxG9Et7R_-ZTZpLQJYTjXm9TEe40V_ZRHg@mail.gmail.com> <CAOLwVUmYm0shGzdxfyg6LXSDgxa1hxF_Kh1oRDZXKtupvGB3VQ@mail.gmail.com> <CAOLwVUmNc_kZgbuKO4VY2mTBAV4FkwrLT=YdK1qJZhsK=sjbMQ@mail.gmail.com> <alpine.DEB.2.00.1302040930540.27333@cobra.newdream.net> <51102210.2040300@inktank.com> <CAOLwVUknsZnGeT8dT8KcjNy4OQ2V5j9sg0Ry_SCq+YDb8ctSdw@mail.gmail.com> <CAPYLRziYOHRVeT5ZbDWjn2K3q=pVc8=fTQqcfGMnmVd9UOLnyA@mail.gmail.com> <CAOLwVUn3o=RKci50jVEPvNmkGrzpi_43M=Cp_HGNYL6ye_68VA@mail.gmail.com> <CABY
 iri8C9pSCW0a+ZZhLHGWL3+Eh1=8Y6brsPc2S1fvB1G1dYQ@mail.gmail.com> <511F4CAC.6020405@42on.com> <51225AD7.8080606@de-punkt.de> <CA+4uBUY1KaDcHFn_BTQ0TZJcokSh8MRUd25VQ_PBJ5EXNnPEEw@mail.gmail.com
 >
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-1.de-punkt.de ([93.190.64.237]:57640 "EHLO
	mail-1.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933352Ab3BSTuo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 14:50:44 -0500
In-Reply-To: <CA+4uBUY1KaDcHFn_BTQ0TZJcokSh8MRUd25VQ_PBJ5EXNnPEEw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Am 19.02.13 20:23, schrieb Samuel Just:
> Can you confirm that the memory size reported is res?
> -Sam#

I think it was virtual, seeing it was the SIZE parameter in ps.
However, we ran into massive slow request issues as soon as the memory
started ballooning.

--ck

