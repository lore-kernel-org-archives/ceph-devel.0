From: Casey Bodley <cbodley@redhat.com>
Subject: Re: Fork and RDMA operations
Date: Wed, 24 Aug 2016 17:18:52 -0400
Message-ID: <d026edff-3e36-e3e3-42d8-811534638439@redhat.com>
References: <emc456988a-f658-4bfd-b373-ceec459da0a7@lt-vu-7440>
 <alpine.DEB.2.11.1608121314380.17762@piezo.us.to>
 <CACJqLybXfss4ay5+9WV6Ux1myrkDBiBN2jUSrbVKB44kak-XQg@mail.gmail.com>
 <alpine.DEB.2.11.1608121625320.17762@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:32944 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754945AbcHXVSy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 17:18:54 -0400
Received: by mail-yw0-f176.google.com with SMTP id r9so18269997ywg.0
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 14:18:54 -0700 (PDT)
Received: from [10.17.151.126] ([12.118.3.106])
        by smtp.gmail.com with ESMTPSA id u189sm6416525ywe.25.2016.08.24.14.18.52
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2016 14:18:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1608121625320.17762@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On 08/12/2016 12:27 PM, Sage Weil wrote:
> It seems like it would be simpler to push the fork before any important
> operations.  (And BTW with systemd and upstart we don't fork anyway; it's
> just there for sysvinit.)  The preforker thing is there to make it easy to
> fork early, but keep the parent waiting around so that you can do more
> intialization, print errors, and terminate with an error code if something
> (post-fork) goes wrong.  In theory, there's no reason why we couldn't make
> this almost the very first thing the daemon does so that *all* work is
> done in the child...
>
> sage
>

I've recently run into issues related to fork as well (see my "memory 
leaks related to CephContext and global_init_daemonize()" email). Trying 
to manage resources across a fork is difficult and error-prone, so 
changing how we daemonize could eliminate a whole class of these bugs. 
And as Haomai points out, we're going to great lengths to make things 
work in the current model.

I'm a big fan of Sage's theory that all work could be done in the child 
process, and I'm willing to take on the project if we can reach a 
consensus on the design.

Whether or not we're interested in long-term support for SysV, the 
ability to daemonize is useful our for development workflow (vstart.sh 
in particular). To fill this role, some basic requirements for the 
parent process are:
* don't exit until initialization is finished
* return an error code if initialization failed

As Sage pointed out, this is exactly what Preforker is doing for 
ceph-mon. So we can start by changing the other daemons to use that 
instead of global_init_daemonize().

The next step is to prevent global_init()/common_init()/CephContext from 
doing any work in the parent process (esp. spawning threads for Log, 
CephContextServiceThread, and AdminSocket). Decoupling the config 
parsing from CephContext initialization seems like a natural way to 
accomplish that. So the parent would create and initialize the 
md_config_t object, then after fork, the child would pass that as an 
argument when creating the CephContext.

How does that sound for a start?

Casey
