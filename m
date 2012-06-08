From: Tommi Virtanen <tv@inktank.com>
Subject: Re: CentOS 6.2 build error
Date: Fri, 8 Jun 2012 10:00:04 -0700
Message-ID: <CADvuQRFW6biLnoTST9z_KpeM-m73+yENBxpVOPL6gf=+zVuZYQ@mail.gmail.com>
References: <4FD22960.2040006@genome.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39168 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934393Ab2FHRAZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jun 2012 13:00:25 -0400
Received: by dady13 with SMTP id y13so2593101dad.19
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jun 2012 10:00:25 -0700 (PDT)
In-Reply-To: <4FD22960.2040006@genome.wustl.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Weil <mweil@genome.wustl.edu>
Cc: ceph-devel@vger.kernel.org

On Fri, Jun 8, 2012 at 9:33 AM, Matt Weil <mweil@genome.wustl.edu> wrote:
>> osdc/ObjectCacher.cc: In member function 'int
>> ObjectCacher::_readx(ObjectCacher::OSDRead*, ObjectCacher::ObjectSet*,
>> Context*, bool)':
>> osdc/ObjectCacher.cc:1043: error: 'INT_MAX' was not declared in this scope

This should be fixed in 9a9418ebfde1b29416c60da3e7fcf4f1e097e96c,
which will be included in the next release.
