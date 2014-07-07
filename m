From: Koleos Fuscus <koleosfuscus@gmail.com>
Subject: Markov models for Ceph
Date: Mon, 7 Jul 2014 17:19:57 +0200
Message-ID: <CACUN8h1j=j-=37TRcnauqGuxMff3Ebs4x5jewY3KefOgDprp8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35677 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbaGGPT6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jul 2014 11:19:58 -0400
Received: by mail-ig0-f171.google.com with SMTP id h18so10895197igc.16
        for <ceph-devel@vger.kernel.org>; Mon, 07 Jul 2014 08:19:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Kyle Bader <kyle@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

Hello Loic,

You ask previously:
In other words, is there a place where one could set things like "disk
fail % of the time" and "network is X Gb/s" and "repairing a disk
failure requires disk require reading B bytes from M disks" ? As far
as I understand, such factors cannot be expressed with a single
formula and this is why a Markov model is useful.

I think we need to run simulations to have a more precise estimation
of the reliability of an erasure coded system. Markov models are not
as flexible as you may think. Besides, solving equations when the
number of components that may fail is large makes the problem not
trivial. Maybe standard simulation is enough. As observed by Greenan
in his thesis, standard simulations have problems with rare events
which may not be observed during simulation time. I don't know if we
should care about rare events for comparing methods..

Greenan released the software used for his thesis. It is completely
developed in Python.
http://www.kaymgee.com/Kevin_Greenan/Software.html

I found Greenan tool while trying to validate the results of ceph-tool
and the numbers are completely different:

For instance:

Parameters for ceph tool:
Disk type consumer, FIT1=2167, FIT2=2167
Size: 2000GiB
RAID-6
Replace 0h
Rebuild 6000MiB/s
Volumes:8
NRE model: ignore
Period: 10 years

(I used this numbers to compared with model 2DFT.disk.model of Greenan tool)

Parameters for  Greenan HFRS tool
python mm_solve.py -m 2DFT.disk.model -M

Results

CEPH:

    storage               durability    PL(site)  PL(copies)
PL(NRE)     PL(rep)    loss/PiB

    ----------            ----------  ----------  ----------
----------  ----------  ----------

    RAID-6: 6+2             11-nines   0.000e+00   1.318e-12
0.000e+00   0.000e+00   9.887e+02


HRFS:

Analytic MTTDL:  4.06111903031e+12
*********************
Analytic prob. of failure: 2.15660e-08
*********************

Could you check if the parameters for ceph are correct and equivalent
to HRFS model?Do you think it has sense to include Greenan tool.
Greenan has a number of models including nonMDS codes. I am not sure
yet how we can describe the LRC code in this platform but it might be
possible.

koleosfuscus

________________________________________________________________
"My reply is: the software has no known bugs, therefore it has not
been updated."
Wietse Venema
