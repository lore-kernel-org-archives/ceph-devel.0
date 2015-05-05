From: Sage Weil <sweil@redhat.com>
Subject: Re: Preparing hammer v0.94.2 release
Date: Tue, 5 May 2015 09:30:04 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505050929140.13336@cobra.newdream.net>
References: <87383bmfzz.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1536607234-1430843406=:13336"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53094 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964916AbbEEQbO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 May 2015 12:31:14 -0400
In-Reply-To: <87383bmfzz.fsf@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1536607234-1430843406=:13336
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 5 May 2015, Abhishek L wrote:
> Hi Sage
> 
> Loïc and I have been working towards backporting issues for the next
> hammer release, and we have been able to backport the commits marked for
> hammer backports and successfully run the integration suites. The tasks
> are tracked at http://tracker.ceph.com/issues/11492. Do you think, the
> next hammer release is ready to be published, in which case, we'll
> proceed to ask the respective project leads to sign off the release and
> begin the QE process.

Let's do it!  I think the main things to watch out for are the RGW fixes 
and the deleted PG fix from Sam.  I think they are both in now?

sage

--557981400-1536607234-1430843406=:13336--
