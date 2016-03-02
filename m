From: Ken Dreyer <kdreyer@redhat.com>
Subject: ceph OSD facts file
Date: Wed, 2 Mar 2016 15:50:37 -0700
Message-ID: <CALqRxCwLovLsdhWKMztqsuz5Mv46XYyjU6Z9O9BRt1GtnONKBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37981 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbcCBWuj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2016 17:50:39 -0500
Received: by mail-wm0-f49.google.com with SMTP id l68so9198415wml.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Mar 2016 14:50:38 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Loic,

In Red Hat we're interested in having a Ceph "facts" file that we can
integrate with RHEL's subscription-manager (upstream
http://www.candlepinproject.org/ fyi) in order to report on the
available raw disk capacity available per OSD.

We need a script to write a "/etc/rhsm/facts/ceph_disk.facts" file.
That file needs to contain JSON of the form:

{
  "band.storage.usage": <integer number of TB used on this node, such as 55>
}

for example:
{
  "band.storage.usage": 55
}

As long as that file exists (and it can be named anything that ends in
".facts") the contents will be read in and added to the system facts.
On RHEL this can be verified by running `subscription-manager facts`
to ensure that your value is showing up properly.

In terms of creating this .facts file, we will need a script to do
that. We could call it /usr/bin/ceph-update-fact-file, or make it a
ceph-disk sub-command, or whatever you want, really.

The facts file should be kept up-to-date every four hours, which makes
me think that we could implement this as a systemd service and timer.
Something like

  $ cat /etc/systemd/system/ceph-update-facts-file.service

  [Unit]
  Description=Update Ceph OSD fact file

  [Service]
  Type=oneshot
  ExecStart=/usr/bin/ceph-update-fact-file


...and:

  $ cat /etc/systemd/system/ceph-update-facts-file.timer
  [Unit]
  Description=Trigger an automatic rewrite every four hours

  [Timer]
  OnCalendar=4hours
  Persistent=true

  [Install]
  WantedBy=multi-user.target

(The above is untested, it's just an idea).  What do you think?
