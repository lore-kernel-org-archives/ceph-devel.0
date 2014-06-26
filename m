From: Koleos Fuscus <koleosfuscus@gmail.com>
Subject: state model diagram
Date: Thu, 26 Jun 2014 02:29:40 +0200
Message-ID: <CACUN8h3uudxbkxBNQYZX8_UV1WYOXfBjoivBGCZJhO4N2yZdKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:46246 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754496AbaFZA3l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jun 2014 20:29:41 -0400
Received: by mail-ie0-f175.google.com with SMTP id tp5so2322506ieb.6
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jun 2014 17:29:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kyle Bader <kyle@inktank.com>, Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I found a state model diagram in the page that explains peering
(http://ceph.com/docs/firefly/dev/peering/). The image cannot be
visualised correctly. I build the docs and could open the image in an
appropriate size using graphviz but still the layout is too complex
and messy.
I decided to do my own state model to collaborate in the understanding
of ceph. Actually, it helps me to measure my own understanding of the
system. Using the diagram facilitates the decision of modeling one
event or skip another. You can find the diagram here:
https://wiki.ceph.com/Development/Add_erasure_coding_to_the_durability_model/Technical_details_on_the_model

Please give me your comments.

koleosfuscus

________________________________________________________________
"My reply is: the software has no known bugs, therefore it has not
been updated."
Wietse Venema
