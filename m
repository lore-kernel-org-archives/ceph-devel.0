From: David Zafman <dzafman@redhat.com>
Subject: Re: pg scrub check problem
Date: Wed, 28 Oct 2015 17:26:27 -0700
Message-ID: <563167B3.1040504@redhat.com>
References: <000001d11164$7fa470a0$7eed51e0$@com>
 <alpine.DEB.2.00.1510281712280.1004@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53119 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbbJ2A03 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Oct 2015 20:26:29 -0400
In-Reply-To: <alpine.DEB.2.00.1510281712280.1004@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, changtao381 <changtao381@163.com>
Cc: 'ceph-devel' <ceph-devel@vger.kernel.org>


Good point.  In my previous response I did "echo garbage > 
........./foo__head_7FC1F406__1" to corrupt a replica.

David

On 10/28/15 5:13 PM, Sage Weil wrote:
> Becuse you *just* wrote the object, and the FileStore caches open file
> handles.  Vim renames a new inode over the old one so the open inode is
> untouched.
>
> If you restart the osd and then scrub you'll see the error.
>
> sage
>
