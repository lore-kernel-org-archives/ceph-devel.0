From: "Christopher R. Hertel" <crh@redhat.com>
Subject: Ceph authentication/authorization paradignms
Date: Thu, 14 Aug 2014 13:10:30 -0400 (EDT)
Message-ID: <1355490291.31383019.1408036230928.JavaMail.zimbra@redhat.com>
References: <1642211910.31382003.1408036197918.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:43035 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbaHNRKc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Aug 2014 13:10:32 -0400
Received: from zmail11.collab.prod.int.phx2.redhat.com (zmail11.collab.prod.int.phx2.redhat.com [10.5.83.13])
	by mx5-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s7EHAVFF030373
	for <ceph-devel@vger.kernel.org>; Thu, 14 Aug 2014 13:10:31 -0400
In-Reply-To: <1642211910.31382003.1408036197918.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Ceph Folks:

Hi.  I am new to Ceph but I've been around in the Open Source world for a
while, working on a variety of different projects (mostly Windows Interop
stuff).  I was asked to take a look at the authentication mechanisms used in
Ceph, focusing on two key areas:

  * Calamari
  * Ceph client authentication to the Ceph cluster.

I am purposefully avoiding anything to do with the internal
service-to-service authentication/authorization system (that is, Cephx) for
two reasons.  The first is that Cephx is specifically designed for Ceph's
many-to-many environment, and the second is that it is sufficiently isolated
that I don't believe it needs to be modified to work with new external
authentication mechanisms.

Below is a quick overview of my thoughts on this topic.


Ceph and Calamari Authentication Expansion
==========================================

I'll keep this quick and simple.  It's a summary of what I've learned
and where I'm headed on this topic.

Adding LDAP Authentication to Calamari
--------------------------------------

  This should be easy, as the Django modules to do this already exist.  The
  trick will be creating accounts in Django and mapping those to existing
  LDAP accounts.  We can't just grant access to anyone who has a valid LDAP
  account, so access control would still be handled by Django and LDAP would
  be limited to authentication only.

  I just need to test this to see how the pieces fall together.

Adding Roles to Calamari
------------------------

  There was a discussion of setting up roles for Calamari, such that
  different roles would have different levels of control over the Ceph
  cluster.

  Django already supports the concept, in a variety of ways.  The first step
  here is to define sensible roles that will work within Django.  I have
  seen a couple of proposals.  The simplest one would be a ReadOnly role and
  a FullControl role.

Adding Kerberos and/or LDAP Auth for Ceph Clients
-------------------------------------------------

  I have set up a FreeIPA server so that I can have something to test
  against.  FreeIPA provides both LDAP and Kerberos authentication.

  There are different opinions regarding the priority of LDAP vs. Kerberos.
  I'll aim to get done first what I can get done first, and work from
  there.

  Right now, I have working LDAP authentication code using the simplest form
  of LDAP authentication.  My next step is to ensure that the authentication
  is encrypted.

  Note that the FreeIPA folks, who are keenly interested in helping us out
  on this project, are adising against trying to get LDAP auth working and
  recommend going directly to their tools.  I am still open to providing
  both mechanisms, assuming that LDAP auth can be made to work securely
  without too much end-user overhead.

FreeIPA and SSSD
----------------

  FreeIPA bundles LDAP and Kerberos support, and can integrate with Active
  Directory.  Also, the folks who work on it are friends and
  colleagues...folks I know fairly well.  They are interested in this
  project, and I want to better understand how integrating with FreeIPA can
  simplify authentication setup.  One key advantage of integrating with
  FreeIPA is that FreeIPA already handles a lot of gnasty compatibility,
  failover, and general complexity issues that people run into when trying
  to make use of existing authentication systems.

  SSSD is the client-side piece.  It maintains credentials in a secure
  fashion, so that users don't have to re-authenticate every time they
  connect to a new service (that uses the same authentication service).
  Integrating with SSSD is a longer-term goal.

Active Directory
----------------

  This is basically Kerberos or LDAP authentication, with some twists.
  Microsoft, for instance, believes in case-insensitivity.  Not so for
  standard Kerberos.  Once we have extended authentication working, we can
  address the specifics of AD.  Again, FreeIPA may help us solve some of
  this.

Chris -)-----
