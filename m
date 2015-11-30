From: Casey Bodley <cbodley@redhat.com>
Subject: updates to the fio objectstore engine
Date: Mon, 30 Nov 2015 10:01:27 -0500 (EST)
Message-ID: <411815055.24643573.1448895687464.JavaMail.zimbra@redhat.com>
References: <1020408809.24616459.1448894405323.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:54435 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071AbbK3PB3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Nov 2015 10:01:29 -0500
In-Reply-To: <1020408809.24616459.1448894405323.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Mark Nelson <mnelson@redhat.com>, Haomai Wang <haomaiwang@gmail.com>, "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>

Hi folks,

I made another pass at the fio objectstore engine over the long weekend. Some of the major changes:

* added support for multiple jobs at a time by splitting global/ObjectStore initialization into a new Engine class

* when run with nr_files > 1, the objects are spread over multiple collections to model the concurrency we get from placement groups

* replaced other options with a 'conf' option to read in a ceph.conf

* moved into src/test/fio and added a README and example job/config files

You can find the pull request at https://github.com/ceph/ceph/pull/5943. Testing and feedback is appreciated!

Casey
