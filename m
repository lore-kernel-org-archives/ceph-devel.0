From: John Spray <jspray@redhat.com>
Subject: Changes to md_config_t
Date: Fri, 14 Jul 2017 15:23:13 +0100
Message-ID: <CALe9h7fOeO07MH--+R40QoV2LHxPwZ6WDVhM=H4Raf09rqhjYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37361 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753968AbdGNOXf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Jul 2017 10:23:35 -0400
Received: by mail-wm0-f53.google.com with SMTP id i127so24318862wma.0
        for <ceph-devel@vger.kernel.org>; Fri, 14 Jul 2017 07:23:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi all,

There's a change headed for master soon
(https://github.com/ceph/ceph/pull/16211) that will rework how config
settings are declared.  Currently they're declared using a
preprocessor macro, which is a bit too inflexible for some desirable
enhancements like having different defaults for clients vs servers,
adding more bounds/range checking, and adding more descriptive doc
metadata.

The thing that will effect you immediately is how to add new config settings:
 - Add them in common/options.cc
 - Access them using md_config_t::get()

The old-style definitions for existing settings still exist in
common/legacy_config_opts.h.  Do *not* add new definitions to that
file.  All the definitions in that file now have equivalent
definitions in common/options.cc, and the ones in common/options.cc
are authoritative.

The old header lives on in order to generate C++ member definitions
for the options in md_config_t (i.e. so that you can get at them with
g_conf->my_config_opt).  Once the consuming code has been modified to
avoid accessing them that way, the entries from legacy_config_opts.h
can be removed.

This sacrifices the compile-time check that you would previously get
by accessing a class member.  The benefit is that we can do all the
new-style stuff with clean C++, that we can in principle load
definitions at runtime (e.g. from the planned central mon config
store), and that md_config_t will now know which options are really in
use (because they're accessed by function and not by direct member
access).

John
