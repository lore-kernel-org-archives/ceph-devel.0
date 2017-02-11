From: Loic Dachary <loic@dachary.org>
Subject: libcrush 1.0.0 published
Date: Sat, 11 Feb 2017 13:06:19 +0100
Message-ID: <7b12f52c-0a79-b153-7ec8-1e398a16d925@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:42537 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751794AbdBKMGY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 11 Feb 2017 07:06:24 -0500
Received: from mfilter18-d.gandi.net (mfilter18-d.gandi.net [217.70.178.146])
        by relay2-d.mail.gandi.net (Postfix) with ESMTP id 39D99C5A54
        for <ceph-devel@vger.kernel.org>; Sat, 11 Feb 2017 13:06:22 +0100 (CET)
Received: from relay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
        by mfilter18-d.gandi.net (mfilter18-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id cVpbPijnHdPD for <ceph-devel@vger.kernel.org>;
        Sat, 11 Feb 2017 13:06:20 +0100 (CET)
Received: from [192.168.3.6] (x4e347344.dyn.telefonica.de [78.52.115.68])
        (Authenticated sender: loic@dachary.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 4C388C5A49
        for <ceph-devel@vger.kernel.org>; Sat, 11 Feb 2017 13:06:20 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

tl;dr: libcrush first release with API documentation, packaged for Fedora and Debian GNU/Linux

libcrush is a standalone library containing the C files from the Ceph crush directory. We hope it will be useful in contexts other than Ceph and that new ideas and robust code will emerge as a result.

The code in this first version of libcrush[0] is an exact copy of the code in Ceph. The API documentation[1] was added in the files so that it is closer to the code and easier to update when it changes. While writing the documentation with Adam Emerson, Sage Weil & Nathan Cutler, a few minor inconsistencies were discovered[5] but not fixed. The goal was to package and document; fixing bugs at the same time would have delayed the release. Ilya Dryomov reviewed the documentation changes to verify they would not be too much of an inconvenience when copying the files over in the next linux kernel release. Except for the API, the libcrush documentation is in a wiki [9]. Sahid Ferdjaoui helped draft a one-page introduction[9] explaining the purpose of CRUSH which is handy to answer the developer
  asking: "how can libcrush help me ? what does it do ?". 

The packaging part was made easy thanks to Nathan Cutler for the .spec file[4] and Nicolas Dandrimont for Debian GNU/Linux[3]. To stay close to what Ceph does, cmake was used for compilation and tests with help from Kefu Chai. libcrush also uses the same tool as Ceph for building the release tarball[2]: git-archive-all.sh.

There are no unit tests in Ceph for the C part of crush, although there are many for the C++ wrapper around it. A few were written, using googletests to stay close to Ceph, and they are run on every build by the GitLab CI whenever a merge request is submitted. They are also run when the packages are built, either for Fedora or Debian GNU/Linux. The integration tests are extremely simple for a C library: they consist of an example C program[8] which is compiled and run after the package is installed. They are in the Debian GNU/Linux package because there is CI infrastructure available for that purpose[7].

If you are inclined to help with libcrush, here are a few action items:

* use libcrush in an existing storage project (or non-storage if relevant ?)
* proofreading the API documenation
* improving the wiki[9]
* writing unit tests to get more coverage
* adding coverage reports using lcov

This week-end I'll look into sheepdog to see if libcrush could be useful there and report progress at http://libcrush.org/main/libcrush/issues/16.

Cheers

[0] http://libcrush.org/main/libcrush
[1] API documentation http://doc.libcrush.org/master/group___a_p_i.html
[2] http://download.libcrush.org/libcrush/releases/libcrush-1.0.0.tar.gz
[3] https://tracker.debian.org/pkg/libcrush
[4] https://bugzilla.redhat.com/show_bug.cgi?id=1421245
[5] http://libcrush.org/main/libcrush/issues
[6] https://github.com/meitar/git-archive-all.sh
[7] https://ci.debian.net/
[8] http://libcrush.org/main/libcrush-debian/tree/debian/sid/debian/tests
[9] http://libcrush.org/main/libcrush/wikis/home

-- 
Loïc Dachary, Artisan Logiciel Libre
