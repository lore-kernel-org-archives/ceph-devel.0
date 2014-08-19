From: Gregory Farnum <greg@inktank.com>
Subject: Re: Ceph authentication/authorization paradignms
Date: Tue, 19 Aug 2014 14:57:59 -0700
Message-ID: <CAPYLRzixD8O5C8K_Q0yvD=3YCMwuWQJg4HFOJ5nss4b4m_0U8g@mail.gmail.com>
References: <1642211910.31382003.1408036197918.JavaMail.zimbra@redhat.com>
	<1355490291.31383019.1408036230928.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:56763 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbaHSV6A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Aug 2014 17:58:00 -0400
Received: by mail-vc0-f182.google.com with SMTP id hy4so8247584vcb.13
        for <ceph-devel@vger.kernel.org>; Tue, 19 Aug 2014 14:57:59 -0700 (PDT)
In-Reply-To: <1355490291.31383019.1408036230928.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Christopher R. Hertel" <crh@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Aug 14, 2014 at 10:10 AM, Christopher R. Hertel <crh@redhat.com> wrote:
> Ceph Folks:
>
> Hi.  I am new to Ceph but I've been around in the Open Source world for a
> while, working on a variety of different projects (mostly Windows Interop
> stuff).  I was asked to take a look at the authentication mechanisms used in
> Ceph, focusing on two key areas:
>
>   * Calamari
>   * Ceph client authentication to the Ceph cluster.
>
> I am purposefully avoiding anything to do with the internal
> service-to-service authentication/authorization system (that is, Cephx) for
> two reasons.  The first is that Cephx is specifically designed for Ceph's
> many-to-many environment, and the second is that it is sufficiently isolated
> that I don't believe it needs to be modified to work with new external
> authentication mechanisms.

I'm a little confused here. CephX is how clients authenticate to the
Ceph cluster...how are we going to add Kerberos auth or whatever
without getting involved in that?
Perhaps I'm misunderstanding the scope of what you're trying to do.
-Greg
