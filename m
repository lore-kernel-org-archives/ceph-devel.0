From: HarmeekSingh Bedi <harmeeksingh@gmail.com>
Subject: Ceph question
Date: Sun, 8 Jul 2012 18:26:52 -0700
Message-ID: <CALLwk6t2RXyRN6Kvc4s21pQRLZxYhrAkf01MxbOOuTP6dOu8aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48166 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab2GIB0y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Jul 2012 21:26:54 -0400
Received: by bkwj10 with SMTP id j10so5570802bkw.19
        for <ceph-devel@vger.kernel.org>; Sun, 08 Jul 2012 18:26:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi there.

  Quick question - I was looking at the code to understand the CRUSH
placement based on unique bijection based on the prime number
generation - I looked at the code and could not locate the specific
code where we generate p > m as described in the papers.
bucket_perm_choose seems to be use "jenkins" hash function to choose a
permutation that is different from the paper ? Would the code still
generate a unique bijection from set {1....m} -> some permutation of
the same set to garauntee that the replica is not placed on the same
sub-cluster devices

Am I missing something here? Kindly help me understand.

Regards
Harmeek
