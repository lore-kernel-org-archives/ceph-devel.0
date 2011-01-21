From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Very basic problems on my CEPH testbed
Date: Fri, 21 Jan 2011 08:26:41 -0700
Message-ID: <1295623601.6777.89.camel@sale659.sandia.gov>
References: <1295547721.3271.37.camel@indica.cc.iitb.ac.in>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:60864 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398Ab1AUP0z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Jan 2011 10:26:55 -0500
In-Reply-To: <1295547721.3271.37.camel@indica.cc.iitb.ac.in>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ajit@iitb.ac.in" <ajit@iitb.ac.in>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

There was a recent osd journaling bug fix that is 
in the testing branch of 
  git://ceph.newdream.net/git/ceph.git

It should be in v0.24.2 when it is released,
according to http://tracker.newdream.net/issues/666.

I experienced frequent hangs on large writes
until this bug was fixed.

The obvious manifestation of this bug was that
osds would assert like this:
  FAILED assert(repop_queue.front() == repop)

However, I also experienced hangs during heavy
writing where the osds would go idle and clients
had outstanding write requests that never completed.
I was never able to isolate the cause, but I haven't 
seen that behavior since this bug was fixed.

-- Jim

On Thu, 2011-01-20 at 11:22 -0700, Ajit K Jena wrote:
> Dear List members,
> 
> We have setup a CEPH testbed based on Fedora Core 14
> machines with 4 GB memory on all. We are using CEPH
> version 0.24 with the components as below:
> 
>         one mds and one cmon (physically on the same machine)
>         two ods (ods1 and ods2)
>         btrfs is used
> 
> The distributed volume is mounted on two client machines.
> When we created small files (basically text files running
> to hundreds of bytes) we have no issues. The files (both
> the metadata and the contents) are consistently visible
> on both the clients.
> 
> The moment we try to store files of sizes 1 megabyte and
> beyond the clients start hanging. The only way out is
> "HARD REBOOT".
> 
> I am very much aware that CEPH is not yet fit for live
> deployment and is still undergoing rapid developments.
> However, I wish to know if others have got results
> better than this.
> 
> Regards.
> 
> --ajit
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


