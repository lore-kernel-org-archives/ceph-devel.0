From: sheng qiu <herbert1984106@gmail.com>
Subject: Fwd: does ceph consider the device performance for distributing data?
Date: Wed, 12 Sep 2012 15:27:40 -0500
Message-ID: <CAB7xdi=PSuyqbE7bp822KXSYhADrDF8Lb5AVC7m8qVRoPv8Qdw@mail.gmail.com>
References: <CAB7xdi=XvPL=pkht-gVnmMwyfA6aVn2HWV9_v4Taitjegc=zWQ@mail.gmail.com>
	<CADvuQRHWuFRqAs7w4D+mXEC24e5Sc5hpG5eXWGPMfZvkZE9gYg@mail.gmail.com>
	<CAB7xdinvp83eeXK+dDS6WZWX=FvYhLLWv2=SBP+x+kDOMu2Bbg@mail.gmail.com>
	<CADvuQRGNzUk8_KBDAvYho8N_LWo88jHXLQTxXLZTQRDmbANG1w@mail.gmail.com>
	<CAB7xdi=YiLo=ySVL1uQOis7LhgmTCLD-6QpRzRSrT6O76q7foA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:64991 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136Ab2ILU1l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Sep 2012 16:27:41 -0400
Received: by ieje11 with SMTP id e11so3644985iej.19
        for <ceph-devel@vger.kernel.org>; Wed, 12 Sep 2012 13:27:41 -0700 (PDT)
In-Reply-To: <CAB7xdi=YiLo=ySVL1uQOis7LhgmTCLD-6QpRzRSrT6O76q7foA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

---------- Forwarded message ----------
From: sheng qiu <herbert1984106@gmail.com>
Date: Wed, Sep 12, 2012 at 3:26 PM
Subject: Re: does ceph consider the device performance for distributing data?
To: Tommi Virtanen <tv@inktank.com>


actually i have read both these two papers. i understand the theory
but just curious about how is it implemented within the codes. i
looked into the ceph source codes, it seems very complicated for me.
i want to read the codes about distribution workloads among OSDs, can
you give some clue about which files are related with, If it is
convenient?   i am a Ph.d student and just for my research cares.

Thanks,
Sheng

On Wed, Sep 12, 2012 at 3:20 PM, Tommi Virtanen <tv@inktank.com> wrote:
> On Wed, Sep 12, 2012 at 1:15 PM, sheng qiu <herbert1984106@gmail.com> wrote:
>> may i ask which part of codes within ceph deal with the distribution
>> of workloads among the OSDs? i am interested in ceph's source codes
>> and want to understand that part of codes.
>
> You want to read the academic papers on CRUSH (or just the whole Ceph
> paper), to properly understand that part.
>
> http://ceph.com/resources/publications/



--
Sheng Qiu
Texas A & M University
Room 332B Wisenbaker
email: herbert1984106@gmail.com
College Station, TX 77843-3259


-- 
Sheng Qiu
Texas A & M University
Room 332B Wisenbaker
email: herbert1984106@gmail.com
College Station, TX 77843-3259
