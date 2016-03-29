From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Virtualenv tests still nort running...
Date: Tue, 29 Mar 2016 13:31:52 +0200
Message-ID: <56FA67A8.6050809@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:50434 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751895AbcC2LcC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 29 Mar 2016 07:32:02 -0400
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 0D5BC1534C6
	for <ceph-devel@vger.kernel.org>; Tue, 29 Mar 2016 13:31:58 +0200 (CEST)
Received: from [IPv6:2001:4cb8:3:1:301d:d194:f8e3:4290] (unknown [IPv6:2001:4cb8:3:1:301d:d194:f8e3:4290])
	by smtp.digiware.nl (Postfix) with ESMTP id 2514D153401
	for <ceph-devel@vger.kernel.org>; Tue, 29 Mar 2016 13:31:57 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>


Hi,

I have rebased to the most recent HEAD before building verything again.
But the testrun still is unable to get the virtualenv correct.

Suggestions on how to diagnose this?

===========
cp -f ./fetch_config ./sample.fetch_config
cd ./ceph-detect-init ; ../tools/setup-virtualenv.sh ; test -d 
wheelhouse && export NO_INDEX=--no-index ; virtualenv/bin/pip install 
$NO_INDEX --use-wheel --find-links=file://$(pwd)/wheelhouse -e .
/bin/sh: ../tools/setup-virtualenv.sh: not found
/bin/sh: virtualenv/bin/pip: not found
Makefile:32259: recipe for target 'ceph-detect-init/virtualenv' failed
===========

path for setup-virtual
./src/tools/setup-virtualenv.sh

===========
cat ./src/tools/setup-virtualenv.sh
rm -fr virtualenv
virtualenv virtualenv
. virtualenv/bin/activate
# older versions of pip will not install wrap_console scripts
# when using wheel packages
pip --log virtualenv/log.txt install --upgrade 'pip >= 6.1'
if test -d wheelhouse ; then
     export NO_INDEX=--no-index
fi
pip --log virtualenv/log.txt install $NO_INDEX --use-wheel 
--find-links=file://$(pwd)/wheelhouse --upgrade di
stribute
pip --log virtualenv/log.txt install $NO_INDEX --use-wheel 
--find-links=file://$(pwd)/wheelhouse 'tox >=1.9'
if test -f requirements.txt ; then
     pip --log virtualenv/log.txt install $NO_INDEX --use-wheel 
--find-links=file://$(pwd)/wheelhouse -r requi
rements.txt
fi
===========
Perhaps here the virtualenv paths need to be converted into SHELLVARs as 
well?

--WjW
