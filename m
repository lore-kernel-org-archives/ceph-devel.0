From: Jason Dillaman <jdillama@redhat.com>
Subject: helgrind and std::mutex ...
Date: Mon, 19 Sep 2016 21:17:47 -0400
Message-ID: <CA+aFP1DurHE=tx6ntqDp_F-NefCJZDA+OJn7KgSjML8f_PpvHw@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34640 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753440AbcITBRt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Sep 2016 21:17:49 -0400
Received: by mail-pa0-f43.google.com with SMTP id wk8so996500pab.1
        for <ceph-devel@vger.kernel.org>; Mon, 19 Sep 2016 18:17:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Heads up: while attempting to clear out all real and imaginary
helgrind errors reported during librbd teuthology test cases, I've
discovered that helgrind is not compatible with std::mutex's use of
PTHREAD_MUTEX_INITIALIZER -- an optimization which skips the normal
calls to pthread_mutex_init / pthread_mutex_destroy.

When objects using std::mutex are destructed, these mutexes remain in
the helgrind internal tracking tables since pthread_mutex_destroy was
not invoked.  This can result in false positives and even assertion
failures should a pthread_rwlock eventually be allocated at the same
address of a deallocated (but not destroyed) mutex.

These failures are sprinkled throughout the new async messenger code
base (since it relies exclusively on std::mutex instead of Ceph's
Mutex pthread wrapper) and also within osdc's Objecter. For the
short-term, I think my only option will be to disable all helgrind
test cases in the librbd suite since they now provide no value due to
the potential for random false positives or assertion failures.

Jason
