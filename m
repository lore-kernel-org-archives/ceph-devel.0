From: Sam Lang <sam.lang@inktank.com>
Subject: Re: Proposed change to vstart.sh
Date: Mon, 22 Oct 2012 11:08:20 -0500
Message-ID: <50856F74.8020001@inktank.com>
References: <508469CE.3000502@gmail.com> <alpine.DEB.2.00.1210211434320.26885@cobra.newdream.net> <508562A1.2040106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36623 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755575Ab2JVQIV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 12:08:21 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2037086pad.19
        for <ceph-devel@vger.kernel.org>; Mon, 22 Oct 2012 09:08:20 -0700 (PDT)
In-Reply-To: <508562A1.2040106@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joe Buck <jbbuck@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 10/22/2012 10:13 AM, Joe Buck wrote:
> On 10/21/2012 02:35 PM, Sage Weil wrote:

>> Also, we should fix the auth none usage at some point.  :)

I made some changes a while back to fix the auth none problems with 
vstart 
(https://github.com/ceph/ceph/commit/0f7c516f3e1f37c5869f8fbff67f53ca0c90568c). 
  The -x help text inversion was a bug on my part.

Joe what errors do you get with auth none?  I'm able to do vstart.sh -n 
-l (without the -x/-X changes) successfully.

-sam

>>
>> sage
>

