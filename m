From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Debian package dependencies across version
Date: Wed, 8 May 2013 10:21:27 +0200
Message-ID: <CAF6-1L7-VwTQMrB5Mqd4d+fBeiA17UwKFwRkbWeK4K4JR-hZRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:43576 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab3EHIV2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 May 2013 04:21:28 -0400
Received: by mail-bk0-f53.google.com with SMTP id i18so719536bkv.26
        for <ceph-devel@vger.kernel.org>; Wed, 08 May 2013 01:21:27 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,


In the debian/control file, the dependency from one ceph package to
the other doesn't always specify that version should match.
For example the 'ceph' package depends on 'ceph-common' but not on
'ceph-common (= ${binary:Version})'.

The result is that when I did a "apt-get install ceph" to upgrade it (
apt-get upgrade wouldn't have updated it automatically because it had
new dependencies ), it only updated the 'ceph' package and not
librados/ceph-common/...  and I had to make another "apt-get upgrade"
to finish the upgrade.

And if you don't pay attention you could end up with mixed version installed.

Is there a reason not to force all version of installed ceph package to match ?


Cheers,

   Sylvain
