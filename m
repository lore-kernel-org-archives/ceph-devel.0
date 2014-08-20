From: "Christopher R. Hertel" <crh@redhat.com>
Subject: Re: Ceph authentication/authorization paradignms
Date: Wed, 20 Aug 2014 18:20:03 -0400 (EDT)
Message-ID: <361503695.34598023.1408573203316.JavaMail.zimbra@redhat.com>
References: <1642211910.31382003.1408036197918.JavaMail.zimbra@redhat.com> <1355490291.31383019.1408036230928.JavaMail.zimbra@redhat.com> <CAPYLRzixD8O5C8K_Q0yvD=3YCMwuWQJg4HFOJ5nss4b4m_0U8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:45951 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273AbaHTWUE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Aug 2014 18:20:04 -0400
In-Reply-To: <CAPYLRzixD8O5C8K_Q0yvD=3YCMwuWQJg4HFOJ5nss4b4m_0U8g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

[At end...]
----- Original Message -----
> From: "Gregory Farnum" <greg@inktank.com>
> To: "Christopher R. Hertel" <crh@redhat.com>
> Cc: ceph-devel@vger.kernel.org
> Sent: Tuesday, August 19, 2014 4:57:59 PM
> Subject: Re: Ceph authentication/authorization paradignms
> 
> On Thu, Aug 14, 2014 at 10:10 AM, Christopher R. Hertel <crh@redhat.com>
> wrote:
> > Ceph Folks:
> >
> > Hi.  I am new to Ceph but I've been around in the Open Source world for a
> > while, working on a variety of different projects (mostly Windows Interop
> > stuff).  I was asked to take a look at the authentication mechanisms used
> > in
> > Ceph, focusing on two key areas:
> >
> >   * Calamari
> >   * Ceph client authentication to the Ceph cluster.
> >
> > I am purposefully avoiding anything to do with the internal
> > service-to-service authentication/authorization system (that is, Cephx) for
> > two reasons.  The first is that Cephx is specifically designed for Ceph's
> > many-to-many environment, and the second is that it is sufficiently
> > isolated
> > that I don't believe it needs to be modified to work with new external
> > authentication mechanisms.
> 
> I'm a little confused here. CephX is how clients authenticate to the
> Ceph cluster...how are we going to add Kerberos auth or whatever
> without getting involved in that?
> Perhaps I'm misunderstanding the scope of what you're trying to do.
> -Greg
> 

CephX, as I understand it, is one of two mechanisms used to do two jobs.

The first job is to allow the client to log in to the cluster to access
cluster services (storage, basically).  The second is the message validation
that goes on between the various services within the cluster (MONitor, MDS,
OSD...).

The other auth mechanism that is used is, basically, none.  In a secure
environment, it's safe to let your clients connect to your cluster, and
your cluster components communicate, without any ongoing validation.

Anyway, the idea here is to perform the initial logon using Kerberos (or
LDAP), but then have CephX continue to handle the internal message validation.
That avoids any need for changing the deeper internals of Ceph, which is
particularly important because CephX is designed for the many-to-many Ceph
environment.

Chris -)-----
