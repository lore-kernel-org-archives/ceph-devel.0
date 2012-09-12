From: Tommi Virtanen <tv@inktank.com>
Subject: Re: does ceph consider the device performance for distributing data?
Date: Wed, 12 Sep 2012 13:41:16 -0700
Message-ID: <CADvuQREf_7UxtV3bs6gKcSF6aCtaj8bJ_Ydi+SrdWeXnemZ-GA@mail.gmail.com>
References: <CAB7xdi=XvPL=pkht-gVnmMwyfA6aVn2HWV9_v4Taitjegc=zWQ@mail.gmail.com>
 <CADvuQRHWuFRqAs7w4D+mXEC24e5Sc5hpG5eXWGPMfZvkZE9gYg@mail.gmail.com>
 <CAB7xdinvp83eeXK+dDS6WZWX=FvYhLLWv2=SBP+x+kDOMu2Bbg@mail.gmail.com>
 <CADvuQRGNzUk8_KBDAvYho8N_LWo88jHXLQTxXLZTQRDmbANG1w@mail.gmail.com>
 <CAB7xdi=YiLo=ySVL1uQOis7LhgmTCLD-6QpRzRSrT6O76q7foA@mail.gmail.com> <CAB7xdi=PSuyqbE7bp822KXSYhADrDF8Lb5AVC7m8qVRoPv8Qdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:44033 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186Ab2ILUlk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Sep 2012 16:41:40 -0400
Received: by qcro28 with SMTP id o28so1422369qcr.19
        for <ceph-devel@vger.kernel.org>; Wed, 12 Sep 2012 13:41:37 -0700 (PDT)
In-Reply-To: <CAB7xdi=PSuyqbE7bp822KXSYhADrDF8Lb5AVC7m8qVRoPv8Qdw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Sep 12, 2012 at 1:27 PM, sheng qiu <herbert1984106@gmail.com> wrote:
> actually i have read both these two papers. i understand the theory
> but just curious about how is it implemented within the codes. i
> looked into the ceph source codes, it seems very complicated for me.

The CRUSH library is in src/crush. It's tightly integrated into RADOS
and, as you put it, the system as a whole is very complicated. Not
sure what we can do about that; it's fundamentally a complex
distributed programming problem space. The internal notes at
http://ceph.com/docs/master/dev/ may be helpful.
