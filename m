From: Eric Blake <eblake@redhat.com>
Subject: Re: [libvirt] [RFC PATCH v3 1/4] secret: add Ceph secret type
Date: Fri, 28 Oct 2011 11:41:52 -0600
Message-ID: <4EAAE960.9010308@redhat.com>
References: <cover.1319072460.git.josh.durgin@dreamhost.com>	<539f3129dfd5d3f80a06837b63dfc5d355f1acc8.1319072460.git.josh.durgin@dreamhost.com> <20111027082845.GA20878@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:29937 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472Ab1J1RmD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 28 Oct 2011 13:42:03 -0400
In-Reply-To: <20111027082845.GA20878@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Josh Durgin <josh.durgin@dreamhost.com>, libvir-list@redhat.com, ceph-devel@vger.kernel.org

On 10/27/2011 02:28 AM, Daniel P. Berrange wrote:
> On Thu, Oct 20, 2011 at 11:01:24AM -0700, Josh Durgin wrote:
>> From: Sage Weil<sage@newdream.net>
>>
>> Add a new secret type to store a Ceph authentication key. The name
>> is simply an identifier for easy human reference.
>>
>> The xml looks like this:
>>
>> <secret ephemeral='no' private='no'>
>>    <uuid>0a81f5b2-8403-7b23-c8d6-21ccc2f80d6f</uuid>
>>    <usage type='ceph'>
>>      <name>mycluster_admin</name>
>>    </usage>
>> </secret>
>>
>> Signed-off-by: Sage Weil<sage@newdream.net>
>> Signed-off-by: Josh Durgin<josh.durgin@dreamhost.com>
>> ---
>>   docs/schemas/secret.rng      |   10 ++++++++++

Missing docs/formatsecret.html.in changes to document this, but I think 
I managed.

>>   include/libvirt/libvirt.h.in |    3 +++
>>   src/conf/secret_conf.c       |   23 ++++++++++++++++++++++-
>>   src/conf/secret_conf.h       |    1 +
>>   src/secret/secret_driver.c   |    8 ++++++++
>>   5 files changed, 44 insertions(+), 1 deletions(-)
>
> ACK

I'm adding this, and pushing:

diff --git i/docs/formatsecret.html.in w/docs/formatsecret.html.in
index 63a1f2a..01aff2d 100644
--- i/docs/formatsecret.html.in
+++ w/docs/formatsecret.html.in
@@ -39,8 +39,8 @@
        <dd>
          Specifies what this secret is used for.  A mandatory
          <code>type</code> attribute specifies the usage category, 
currently
-        only <code>volume</code> is defined.  Specific usage categories are
-        described below.
+        only <code>volume</code> and <code>ceph</code> are defined.
+        Specific usage categories are described below.
        </dd>
      </dl>

@@ -54,6 +54,18 @@
        this secret is associated with.
      </p>

+    <h3>Usage type "ceph"</h3>
+
+    <p>
+      This secret is associated with a Ceph RBD (rados block device).
+      The <code>&lt;usage type='ceph'&gt;</code> element must contain
+      a single <code>name</code> element that specifies a usage name
+      for the secret.  The Ceph secret can then be used by UUID or by
+      this usage name via the <code>&lt;auth&gt;</code> element of
+      a <a href="domain.html#elementsDisks">disk
+      device</a>. <span class="since">Since 0.9.7</span>.
+    </p>
+
      <h2><a name="example">Example</a></h2>

      <pre>


-- 
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org
