From: Loic Dachary <loic@dachary.org>
Subject: teuthology-suite argument puzzle
Date: Thu, 13 Oct 2016 14:50:46 +0200
Message-ID: <57FF8326.4040209@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:58601 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932162AbcJMMuw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Oct 2016 08:50:52 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Zack,

I wanted to try --rerun and ran into a cryptic error message:

run=loic-2016-10-13_09:20:07-rgw-jewel-backports-distro-basic-smithi
teuthology-suite -k distro --priority 101 --suite rgw --rerun $run --suite-branch jewel --email loic@dachary.org --ceph jewel-backports --machine-type smithi
usage: teuthology-suite --help
       teuthology-suite [-v | -vv ] --suite <suite> [options] [<config_yaml>...]
       teuthology-suite [-v | -vv ] --rerun <name>  [options] [<config_yaml>...]

What did I do wrong ?

Cheers
-- 
Loïc Dachary, Artisan Logiciel Libre
