From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: rgw: authentication rework
Date: Wed, 23 Mar 2016 19:13:14 +0100
Message-ID: <CA+H5UW1rfNQ0atZv+ZiQ63a+27m20LSqmaTRkbZX7G2OobYe9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37776 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755707AbcCWSNQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Mar 2016 14:13:16 -0400
Received: by mail-wm0-f52.google.com with SMTP id p65so35058969wmp.0
        for <ceph-devel@vger.kernel.org>; Wed, 23 Mar 2016 11:13:15 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>

Hello,

I would like to discuss two important changes I think we need to
introduce to RadosGW's authentication & authorization subsystem.

1. Split user data (RGWUserInfo and associated; account in Swift's
   terminology) that a given RGWOp operates on (changes user
   attributes, links new bucket to, lists buckets, get ACLS and so on)
   from identity checked by its verify_permissions() method.

   At the moment, rgw_user that comes from RGWUserInfo stored
   in req_state (req_state::RGWUserInfo::rgw_user) is being used
   there directly. This imposes severe limitations especially on
   Swift API. For example, it's impossible to add account ACLs nor
   reseller admin feature. In turn, authorized user cannot operate
   on someone's else account.

   Patch splitting the authentication identity from account owner
   is available for review [1].

2. The second thing is the infrastructure for authentication engines.
   RadosGW does support a lot of auth backends (S3 Keystone,
   Swift Keystone, LDAP, TempURL, TempAuth to name a few).
   However, the code isn't organized into a formal class structure.

   Things gets really complicated as a backend is supposed not only
   to answer to the question whether request is authenticated or not,
   but also to alter the store (eg. account creation in Keystone auth)
   or request state. At the moment, those responsibilities (read-only
   and read-write) are mixed across the code and - in many cases -
   duplicated (engine X has its own mechanism for filling req_state
   that is awfully similar to its counterpart in engine Y).

   As a result, integrating a new engine or even making small
   changes in authentication subsystem are hard and error-prone.

   IMO we can quite easily improve the situation. Below is my vision:

   - authentication and store/request modification are separated
     into dedicated interfaces: RGWAuthEngine and RGWAuthLoader
     respectively.

   - RGWAuthEngine is a low-level abstraction of authentication
     engine. Upper layers (like RGWHandler::authorize) may
     compose them into pipelines.

   - RGWAuthEngine gets all dependencies it needs through
     constructor and exposes publicly two methods:
      * is_applicable - fast and simple screening method an upper
        layer may use to discover whether a particular engine is
        interested in handling a given request or not.
      * authenticate - authenticates an user and returns appropriate
        RGWAuthLoader if succeeded.

   - Upper layers use RGWAuthLoader to perform all alternations.

   - RGWAuthLoader exposes following methods:
      * load_acct_info - for loading RGWUserInfo,
      * load_user_info - for setting identity used later by RGWOp's
        verify_permissions().
      * modify_request_state.

   - RGWAuthEngine may delegate creation of RGWAuthLoader
     to a factory following an interface that particular engine claims.

   Work on early prototype of the new auth infrastructure may be
   tracked in wip-rgw-swift-auth branch [2] (especially latest commits).

Best regards,
Radoslaw Zarzynski


[1] https://github.com/rzarzynski/ceph/commit/93472a5cc6b5e7cdee5d1d9b50cbcad3d4f24c6b

[2] https://github.com/rzarzynski/ceph/commits/wip-rgw-swift-auth
