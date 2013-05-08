From: Henning Verbeek <hankipanky@gmail.com>
Subject: Cuttlefish installation on debian 6.0 squeeze depends on cryptsetup-bin
Date: Wed, 8 May 2013 10:09:33 +0200
Message-ID: <CAOVDbHa2qS7-O1AyyQSPRcnb8DSrGxf_iKzBWUDkJLVf+uAuSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:57068 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925Ab3EHIJf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 May 2013 04:09:35 -0400
Received: by mail-wi0-f169.google.com with SMTP id h11so4950735wiv.4
        for <ceph-devel@vger.kernel.org>; Wed, 08 May 2013 01:09:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Dear ceph developers,

I just tried to upgrade my ceph installation from bobtail to
cuttlefish on a debian 6.0 squeeze installation. The installation of
package 'ceph' failed due to missing package 'cryptsetup-bin':

  $ sudo apt-get -y install ceph
  Reading package lists... Done
  Building dependency tree
  Reading state information... Done
  Some packages could not be installed. This may mean that you have
  requested an impossible situation or if you are using the unstable
  distribution that some required packages have not yet been created
  or been moved out of Incoming.
  The following information may help to resolve the situation:

  The following packages have unmet dependencies:
   ceph : Depends: cryptsetup-bin but it is not installable
          Recommends: ceph-mds but it is not going to be installed
  E: Broken packages

Package 'cryptsetup-bin' is available only from wheezy onwards:
http://packages.debian.org/search?keywords=cryptsetup-bin

On squeeze, the package is called 'cryptsetup'.

Can I suggest that the dependency be changed for the squeeze packages?
Thank you.

Cheers,
Henning
