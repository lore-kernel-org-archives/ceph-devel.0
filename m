From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: radosgw
Date: Wed, 23 Jan 2013 19:02:33 +0100
Message-ID: <CAJH6TXgocN-yWD930i+o80ATLLj5sXo+CcDvE4-JuWses7yPmQ@mail.gmail.com>
References: <CAJH6TXg+7Sp=3_B047OG+KGQK00X5ZtKXAT+UB2KROBDaqVruA@mail.gmail.com>
	<CAC-hyiHsL3j9MviM1B0_hhEkt8GeLjeqbWn-ApE82+M+EQYmUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:52141 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754737Ab3AWSCe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 13:02:34 -0500
Received: by mail-we0-f173.google.com with SMTP id r5so418841wey.18
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 10:02:33 -0800 (PST)
In-Reply-To: <CAC-hyiHsL3j9MviM1B0_hhEkt8GeLjeqbWn-ApE82+M+EQYmUA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

2013/1/23 Yehuda Sadeh <yehuda@inktank.com>:
> try
> # radosgw -n client radosgw.gateway

Still doesn't work.

# radosgw -n client radosgw.gateway
error parsing 'client': expected string of the form TYPE.ID, valid
types are: auth, mon, osd, mds, client

# radosgw -n client.radosgw.gateway
# ps aux | grep rados
root      4814  0.0  0.1   7520   748 pts/0    S+   19:02   0:00 grep rados
