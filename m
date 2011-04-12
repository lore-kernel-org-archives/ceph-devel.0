From: Christoph Raible <c.raible@science-computing.de>
Subject: Searching for right tcmalloc Packages on CentOS 5.5
Date: Tue, 12 Apr 2011 10:22:07 +0200
Message-ID: <4DA40BAF.2070404@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.belwue.de ([129.143.2.15]:35066 "EHLO smtp2.belwue.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754709Ab1DLIWK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2011 04:22:10 -0400
Received: from mx4.science-computing.de (mx4.science-computing.de [193.197.16.30])
	by smtp2.belwue.de with ESMTP id p3C8M8lc026247
	for <ceph-devel@vger.kernel.org>; Tue, 12 Apr 2011 10:22:08 +0200 (MEST)
	env-from (prvs=07680a95b=c.raible@science-computing.de)
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 7086F414004
	for <ceph-devel@vger.kernel.org>; Tue, 12 Apr 2011 10:22:08 +0200 (CEST)
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (obitest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s3Ay4GH63Phz for <ceph-devel@vger.kernel.org>;
	Tue, 12 Apr 2011 10:22:07 +0200 (CEST)
Received: from nerva.science-computing.de (nerva.science-computing.de [10.10.16.94])
	by scmail.science-computing.de (Postfix) with ESMTP id D1A54414003
	for <ceph-devel@vger.kernel.org>; Tue, 12 Apr 2011 10:22:07 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by nerva.science-computing.de (Postfix) with ESMTP id C0D8FA3421
	for <ceph-devel@vger.kernel.org>; Tue, 12 Apr 2011 10:22:07 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi @all,

I'm searching for the right tcmalloc package to configure Ceph on
CentOS 5.5 x86_64.

I tried the following packages described in Mailinglist and other Howto's:


     google-perftools-1.3-3.el5.kb.x86_64,
     google-perftools-1.7-1.el5.i386.rpm,
     google-perftools-devel-1.7-1.el5.i386.rpm


But none of them works...  I always get the following error:


     checking for malloc in -ltcmalloc... no

     configure: error: no tcmalloc found (use --without-tcmallo to 
    disable)

     See `config.log' for more details.

Can anyone help me with my problem?


Regards,
Christoph Raible

-- 
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Dr. Roland Niemeier, 
Dr. Arno Steitz, Dr. Ingrid Zech
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Philippe Miltin
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196 


