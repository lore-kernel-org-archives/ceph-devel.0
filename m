From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [PATCH 0/3] Generic libcephfs Java wrappers
Date: Thu, 8 Mar 2012 10:54:24 -0800
Message-ID: <4B306D7B-E017-445D-8F76-AB0EDC7B61D7@cs.ucsc.edu>
References: <4F516A20.8060901@cs.ucsc.edu> <Pine.LNX.4.64.1203070935010.8008@cobra.newdream.net> <3071055F-EFD8-441A-913C-B04C8BC662FF@cs.ucsc.edu> <FCB709D302224AD984BB00F851ACE8C2@dreamhost.com> <E6A73CCF-3C17-42C1-BA41-33E1CADA6675@cs.ucsc.edu> <E71CA82A2DB647E193C249D30CA491A8@dreamhost.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:44730 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757464Ab2CHSyZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Mar 2012 13:54:25 -0500
In-Reply-To: <E71CA82A2DB647E193C249D30CA491A8@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <gregory.farnum@dreamhost.com>
Cc: Noah Watkins <jayhawk@soe.ucsc.edu>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org


On Mar 8, 2012, at 10:48 AM, Greg Farnum wrote:

> On Thursday, March 8, 2012 at 9:30 AM, Noah Watkins wrote:
>> 
>> On Mar 7, 2012, at 1:40 PM, Greg Farnum wrote:
>> 
>>> CephMount::conf_get requires a buf_size. But we freely adjust that if we need more space, so is there any point to it? I can't see callers really having a better idea of size than we do.
>> Good point. I can't think of a reason to publicly expose the buffer length param in CephMount to users, but CephProxy is a private interface. On a related a related note:
>> 
>> int ceph_conf_get(struct ceph_mount_info *cmount, const char *option, char *buf, size_t len);
>> 
>> shouldn't the 'buf' parameter be char ** if libcephfs is going to be doing a re-alloc, or is there some voodoo behind the scenes?
> libcephfs doesn't do a re-alloc there; I was talking about the Java stuff when I said it freely adjusts. :)

The documentation seems to indicate that it does do a malloc. Maybe it is just out of date?

/* Returns a configuration value as a string.
 * If len is positive, that is the maximum number of bytes we'll write into the
 * buffer. If len == -1, we'll call malloc() and set *buf.
 * Returns 0 on success, error code otherwise. Returns ENAMETOOLONG if the
 * buffer is too short. */

>>> I like the states and require_state() stuff. It's making me notice that you need a little more documentation on stuff like closedir and what happens to the CephDirectory under success and error returns. :)
>> 
>> The state checking is really helpful to catch set faults when blindly casting Java long to void* :) I wonder if there is a way to push the state checking even further down in libcephfs? Currently all errors are communicated through a generic CephException, but making things more specific as we go along will be nice.
> 
> I'm not sure how we'd push it farther down in a way that's any cleaner, did you have some thoughts or just a wish to not do it in Java?

Just making unrealistic dreams :) -- I think that the state machine approach is good. Implicitly, users of libcephfs C API must take care do this anyway.

> Oh, and I forgot something important last time: there's no licensing associated with any of these files right now. :) I think we talked previously about making it Apache, but whatever it is should be clearly noted!

Just added a TODO for this. I think it was MIT, but i'll go back and look t the e-mails.

> -Greg
> 

