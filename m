From: liuchang0812 <liuchang0812@gmail.com>
Subject: Re: libcrush 1.0.0 published
Date: Sun, 12 Feb 2017 15:31:09 +0800
Message-ID: <CACKY0b_F4fAPjDYf-2gHpT9HbtWQL4jgx2Z+VutsC8Sut5huWQ@mail.gmail.com>
References: <7b12f52c-0a79-b153-7ec8-1e398a16d925@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f173.google.com ([209.85.213.173]:33873 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbdBLHbL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Feb 2017 02:31:11 -0500
Received: by mail-yb0-f173.google.com with SMTP id j82so21018441ybg.1
        for <ceph-devel@vger.kernel.org>; Sat, 11 Feb 2017 23:31:11 -0800 (PST)
In-Reply-To: <7b12f52c-0a79-b153-7ec8-1e398a16d925@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Awesome work!!

2017-02-11 20:06 GMT+08:00 Loic Dachary <loic@dachary.org>:
> Hi,
>
> tl;dr: libcrush first release with API documentation, packaged for Fedora=
 and Debian GNU/Linux
>
> libcrush is a standalone library containing the C files from the Ceph cru=
sh directory. We hope it will be useful in contexts other than Ceph and tha=
t new ideas and robust code will emerge as a result.
>
> The code in this first version of libcrush[0] is an exact copy of the cod=
e in Ceph. The API documentation[1] was added in the files so that it is cl=
oser to the code and easier to update when it changes. While writing the do=
cumentation with Adam Emerson, Sage Weil & Nathan Cutler, a few minor incon=
sistencies were discovered[5] but not fixed. The goal was to package and do=
cument; fixing bugs at the same time would have delayed the release. Ilya D=
ryomov reviewed the documentation changes to verify they would not be too m=
uch of an inconvenience when copying the files over in the next linux kerne=
l release. Except for the API, the libcrush documentation is in a wiki [9].=
 Sahid Ferdjaoui helped draft a one-page introduction[9] explaining the pur=
pose of CRUSH which is handy to answer the developer asking: "how can libcr=
ush help me ? what does it do ?".
>
> The packaging part was made easy thanks to Nathan Cutler for the .spec fi=
le[4] and Nicolas Dandrimont for Debian GNU/Linux[3]. To stay close to what=
 Ceph does, cmake was used for compilation and tests with help from Kefu Ch=
ai. libcrush also uses the same tool as Ceph for building the release tarba=
ll[2]: git-archive-all.sh.
>
> There are no unit tests in Ceph for the C part of crush, although there a=
re many for the C++ wrapper around it. A few were written, using googletest=
s to stay close to Ceph, and they are run on every build by the GitLab CI w=
henever a merge request is submitted. They are also run when the packages a=
re built, either for Fedora or Debian GNU/Linux. The integration tests are =
extremely simple for a C library: they consist of an example C program[8] w=
hich is compiled and run after the package is installed. They are in the De=
bian GNU/Linux package because there is CI infrastructure available for tha=
t purpose[7].
>
> If you are inclined to help with libcrush, here are a few action items:
>
> * use libcrush in an existing storage project (or non-storage if relevant=
 ?)
> * proofreading the API documenation
> * improving the wiki[9]
> * writing unit tests to get more coverage
> * adding coverage reports using lcov
>
> This week-end I'll look into sheepdog to see if libcrush could be useful =
there and report progress at http://libcrush.org/main/libcrush/issues/16.
>
> Cheers
>
> [0] http://libcrush.org/main/libcrush
> [1] API documentation http://doc.libcrush.org/master/group___a_p_i.html
> [2] http://download.libcrush.org/libcrush/releases/libcrush-1.0.0.tar.gz
> [3] https://tracker.debian.org/pkg/libcrush
> [4] https://bugzilla.redhat.com/show_bug.cgi?id=3D1421245
> [5] http://libcrush.org/main/libcrush/issues
> [6] https://github.com/meitar/git-archive-all.sh
> [7] https://ci.debian.net/
> [8] http://libcrush.org/main/libcrush-debian/tree/debian/sid/debian/tests
> [9] http://libcrush.org/main/libcrush/wikis/home
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
