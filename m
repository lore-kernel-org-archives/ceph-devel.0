From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: 7915 is not resolved
Date: Wed, 13 Jan 2016 13:35:22 +0200
Message-ID: <20160113113521.GA11985@gmail.com>
References: <20160111190619.GA22809@localhost>
 <CAFUG7Cf+7wViua5YZCWt11_Q0253F3E4nzUPkfA9PoA8SHsNJA@mail.gmail.com>
 <CAFUG7CcudK5zu0eezuTmZrsakE4s-oHyPss3cubSRL5txQmA9Q@mail.gmail.com>
 <20160112065305.GA16215@gmail.com>
 <alpine.DEB.2.11.1601120821210.27580@cpach.fuggernut.com>
 <CAFUG7CcVGQBhmO0cRS4u_3Zz7uXbz+fh1rbrhbai45xZAUx=qQ@mail.gmail.com>
 <alpine.DEB.2.11.1601121245040.27580@cpach.fuggernut.com>
 <CAFUG7CcWbwG9fufWFUY=n9CJQFQpG+qQ8wY+3bE+Q2w_FSnb1A@mail.gmail.com>
 <CAFUG7CcFSs8XWD4XWQ6fVvJ13322b=h5vGrgd+4pKfcRiTmjYg@mail.gmail.com>
 <CAFUG7CdPcnxsHuOKVXZWXJdXuAParQTtpeAfkBi6NaHCLrCBqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:33802 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329AbcAMLf0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jan 2016 06:35:26 -0500
Received: by mail-lb0-f173.google.com with SMTP id cl12so71462231lbc.1
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jan 2016 03:35:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAFUG7CdPcnxsHuOKVXZWXJdXuAParQTtpeAfkBi6NaHCLrCBqw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Boris Lukashev <blukashev@sempervictus.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Jan 12, 2016 at 08:06:03PM -0500, Boris Lukashev wrote:
> Thank you sage! The patch below allowed one of the two stuck OSDs to start up.
> Whats the procedure from here? Is there a way to make Ceph consistent?
> OSD 4 is still refusing to start, new error message however.

Could you please post the log for this case? It might be helpful to
set 'debug osd = 20' before starting.

-- 
Mykola Golub
