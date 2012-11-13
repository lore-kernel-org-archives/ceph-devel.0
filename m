From: Steffen Yount <syount@wideorbit.com>
Subject: a Hibernate OGM DataStore Provider for RADOS object stores?
Date: Tue, 13 Nov 2012 19:46:00 +0000 (UTC)
Message-ID: <loom.20121113T194556-333@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48991 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754329Ab2KMTt6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 13 Nov 2012 14:49:58 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1TYMUl-0007mL-Us
	for ceph-devel@vger.kernel.org; Tue, 13 Nov 2012 20:50:04 +0100
Received: from 107-0-15-114-ip-static.hfc.comcastbusiness.net ([107.0.15.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 13 Nov 2012 20:50:03 +0100
Received: from syount by 107-0-15-114-ip-static.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 13 Nov 2012 20:50:03 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I'm not sure this is the place to post something like this, but here goes...

I've mainly been introduced to Ceph from the context of OpenStack integration.
But then, the other day, I read an article about RedHat's new Hibernate OGM
project: a Java Persistence API (JPA) implementation supporting NoSQL
solutions.
http://www.hibernate.org/subprojects/ogm.html

Hibernate OGM currently supports Infinispan, Ehcache, and MongoDB as its
DataStore Providers, with an open interface to implement other DataStore
Providers:
https://community.jboss.org/wiki/HowToWriteADatastoreInHibernateOGM

While Hibernate OGM project is in Beta right now, I can imagine JPA and
Hibernate support could be a big deal for Java developers evaluating back
ends for their object storage needs. 

I can also imagine that Ceph technology and RADOS object stores could get a
popularity/momentum/media boost by being included in a high profile project
like Hibernate OGM.

Unfortunately, I don't have the experience in programming with Hibernate OGM
or the librados libraries to evaluate this myself, but from what I've read,
the technology seems compelling, and so I'm asking here:

Looking at the Hibernate OGM interface and the librados libraries how hard
would it be to implement a Hibernate OGM DataStore Provider for RADOS object
stores?

Is this a project where a prototype could be knocked out in a weekend?

Are RADOS object stores a good technology for NoSQL use cases?

Does anyone else here see value in getting RADOS object stores working with
the Hibernate OGM project?

Anyone interested in taking up the project?

Thanks,
-S


