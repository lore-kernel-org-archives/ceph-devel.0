From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: cmake
Date: Thu, 3 Dec 2015 19:26:52 -0500 (EST)
Message-ID: <295720458.28620860.1449188812348.JavaMail.zimbra@redhat.com>
References: <20151203152436.73e15e38@lembas.zaitcev.lan> <20151203223020.GB17144@ultraspiritum.redhat.com> <20151203170347.33867061@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:33358 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbbLDA0w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 19:26:52 -0500
In-Reply-To: <20151203170347.33867061@lembas.zaitcev.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: "Adam C. Emerson" <aemerson@redhat.com>, ceph-devel@vger.kernel.org

Pete,

Could you share the branch you are trying to build?  (ceph/wip-5073 would not appear to be it.)

Matt

----- Original Message -----
> From: "Pete Zaitcev" <zaitcev@redhat.com>
> To: "Adam C. Emerson" <aemerson@redhat.com>
> Cc: ceph-devel@vger.kernel.org
> Sent: Thursday, December 3, 2015 7:03:47 PM
> Subject: Re: cmake
> 
> On Thu, 3 Dec 2015 17:30:21 -0500
> "Adam C. Emerson" <aemerson@redhat.com> wrote:
> 
> > On 03/12/2015, Pete Zaitcev wrote:
> 
> > > I'm trying to run cmake, in order to make sure my patches do not break it
> > > (in particular WIP 5073 added source files). Result looks like this:
> > > 
> > > [zaitcev@lembas ceph-tip]$ cmake src
> > 
> > I believe the problem is 'cmake src'
> 
> Thanks for the tip about the separate build directory and the top-level
> CMakeLists.txt. However, it still fails like this:
> 
> [zaitcev@lembas build]$ cmake ..
> CMake Error at CMakeLists.txt:1 (include):
>   include could not find load file:
> 
>     GetGitRevisionDescription
> ...................
> 
> Do you know by any chance where it gets that include? Also, what's
> your cmake --version?
> 
> Greetings,
> -- Pete
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
