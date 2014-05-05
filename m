From: Jeff Darcy <jdarcy@redhat.com>
Subject: Re: RADOS translator for GlusterFS
Date: Mon, 5 May 2014 13:38:16 -0400 (EDT)
Message-ID: <1666953774.790843.1399311496408.JavaMail.zimbra@redhat.com>
References: <980181538.654650.1399300829103.JavaMail.zimbra@redhat.com> <355696287.706122.1399303290204.JavaMail.zimbra@redhat.com> <CABBk=J8=GgAPM7qWfs9=OZt6yHVERggiugPui31w4b=GPk8Oow@mail.gmail.com> <1793642728.775752.1399309685692.JavaMail.zimbra@redhat.com> <CA+4uBUaOWEwpet3dr1mzYQtr_Xju8a3aCgFAf4BCu22WGQ+aZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:51115 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755734AbaEERiS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 May 2014 13:38:18 -0400
In-Reply-To: <CA+4uBUaOWEwpet3dr1mzYQtr_Xju8a3aCgFAf4BCu22WGQ+aZg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, gluster-devel@gluster.org

> One important caveat is that rados objects should be limited in size
> (4MB for rbd blocks), so you'll want to chunk files somewhere before
> rados.

OK, that's going to make life interesting.  How dire are the results
of not chunking like this?  Is it just that the data won't be
distributed across multiple OSDs and therefore you'll only get one
OSD's worth of throughput?  Or is it something worse?  There might
be a way that we can use the GlusterFS striping translator on top
of the RADOS translator, but since it currently sits one level lower
(still above replication but below distribution) there might be some
issues there.
