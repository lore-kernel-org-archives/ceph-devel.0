From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: Code Documentation Conventions
Date: Fri, 16 Dec 2011 13:39:51 -0800
Message-ID: <4EEBBAA7.8010000@dreamhost.com>
References: <4EEBAF78.8010605@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:40861 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760426Ab1LPVjv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2011 16:39:51 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 0581BC064
	for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2011 13:50:07 -0800 (PST)
Received: from [192.168.107.213] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id E8CE6C063
	for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2011 13:50:06 -0800 (PST)
In-Reply-To: <4EEBAF78.8010605@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 12/16/2011 12:52 PM, Josh Durgin wrote:
> I've been documenting the librados C api, and would like to get some
> feedback on the format being used. For each function, the format is
> generally:
>
> /**
> * Short description
> *
> * Detailed description when necessary
> *
> * preconditons, postconditions, warnings, bugs or other notes
> *
> * parameter reference
> * return value (if non-void)
> */
>
> Below is some sample documentation. The markup is doxygen, although
> I've had to avoid some directives since breathe (sphinx plugin for
> reading doxygen output) removes contents it doesn't understand.

You can see the sphinx ouptut at:
http://www.joshd.dreamhosters.com/api/librados/#project0librados_8h_1a280e071e73202dca849472814a585717

The function reference all comes from doxygen's processing of 
src/include/rados/librados.h, and the code examples (which I haven't 
changed yet) are from doc/api/librados.rst. In general, I think we 
should document functions in header files and only put code examples or 
larger usage guides outside the code.

I've been focused on making the content correct, so I haven't customized 
the sphinx or doxygen configuration at all. There are lots of things we 
could improve about the output. Also I just noticed breathe is ignoring 
doxygen lists.
