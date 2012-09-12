From: Tommi Virtanen <tv@inktank.com>
Subject: Re: does ceph consider the device performance for distributing data?
Date: Wed, 12 Sep 2012 13:20:55 -0700
Message-ID: <CADvuQRGNzUk8_KBDAvYho8N_LWo88jHXLQTxXLZTQRDmbANG1w@mail.gmail.com>
References: <CAB7xdi=XvPL=pkht-gVnmMwyfA6aVn2HWV9_v4Taitjegc=zWQ@mail.gmail.com>
 <CADvuQRHWuFRqAs7w4D+mXEC24e5Sc5hpG5eXWGPMfZvkZE9gYg@mail.gmail.com> <CAB7xdinvp83eeXK+dDS6WZWX=FvYhLLWv2=SBP+x+kDOMu2Bbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:56693 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab2ILUVQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Sep 2012 16:21:16 -0400
Received: by qcro28 with SMTP id o28so1406757qcr.19
        for <ceph-devel@vger.kernel.org>; Wed, 12 Sep 2012 13:21:15 -0700 (PDT)
In-Reply-To: <CAB7xdinvp83eeXK+dDS6WZWX=FvYhLLWv2=SBP+x+kDOMu2Bbg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Sep 12, 2012 at 1:15 PM, sheng qiu <herbert1984106@gmail.com> wrote:
> may i ask which part of codes within ceph deal with the distribution
> of workloads among the OSDs? i am interested in ceph's source codes
> and want to understand that part of codes.

You want to read the academic papers on CRUSH (or just the whole Ceph
paper), to properly understand that part.

http://ceph.com/resources/publications/
