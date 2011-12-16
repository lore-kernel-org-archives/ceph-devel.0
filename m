From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Code Documentation Conventions
Date: Fri, 16 Dec 2011 12:52:08 -0800
Message-ID: <4EEBAF78.8010605@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:44145 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964973Ab1LPUwI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2011 15:52:08 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id BC3B6C065
	for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2011 13:02:23 -0800 (PST)
Received: from [192.168.107.213] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id B050FC063
	for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2011 13:02:23 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've been documenting the librados C api, and would like to get some
feedback on the format being used. For each function, the format is
generally:

/**
  * Short description
  *
  * Detailed description when necessary
  *
  * preconditons, postconditions, warnings, bugs or other notes
  *
  * parameter reference
  * return value (if non-void)
  */

Below is some sample documentation. The markup is doxygen, although
I've had to avoid some directives since breathe (sphinx plugin for
reading doxygen output) removes contents it doesn't understand.

For higher-level comments, I've been using named sections, and grouping
related functions under them (this would be using @defgroup, but
breathe doesn't seem to support that). @{ and @} delimit a group.

/**
  * @name Configuration
  * These functions read and update Ceph configuration for a cluster
  * handle. Any configuration changes must be done before connecting to
  * the cluster.
  *
  * Options that librados users might want to set include:
  * - mon_host
  * - auth_supported
  * - key, keyfile, or keyring when using cephx
  * - log_file, log_to_stderr, err_to_stderr, and log_to_syslog
  * - debug_rados, debug_objecter, debug_monc, debug_auth, or debug_ms
  *
  * All possible options can be found in src/common/config_opts.h in 
ceph.git
  *
  * @{
  */

/**
  * Configure the cluster handle using a Ceph config file
  *
  * If path is NULL, the default locations are searched, and the first
  * found is used. The locations are:
  * - $CEPH_CONF (environment variable)
  * - /etc/ceph/ceph.conf
  * - ~/.ceph/config
  * - ceph.conf (in the current working directory)
  *
  * @pre rados_connect() has not been called on the cluster handle
  *
  * @param cluster cluster handle to configure
  * @param path path to a Ceph configuration file
  * @returns 0 on success, negative error code on failure
  */
int rados_conf_read_file(rados_t cluster, const char *path);

/**
  * Configure the cluster handle with command line arguments
  *
  * argv can contain any common Ceph command line option, including any
  * configuration parameter prefixed by '--' and replacing spaces with
  * dashes or underscores. For example, the following options are 
equivalent:
  * - --mon-host 10.0.0.1:6789
  * - --mon_host 10.0.0.1:6789
  * - -m 10.0.0.1:6789
  *
  * @pre rados_connect() has not been called on the cluster handle
  *
  * @param cluster cluster handle to configure
  * @param argc number of arguments in argv
  * @param argv arguments to parse
  * @return 0 on success, negative error code on failure
  */
int rados_conf_parse_argv(rados_t cluster, int argc, const char **argv);

/**
  * Configure the cluster handle based on an environment variable
  *
  * The contents of the environment variable are parsed as if they were
  * Ceph command line options. If var is NULL, the CEPH_ARGS
  * environment variable is used.
  *
  * @pre rados_connect() has not been called on the cluster handle
  *
  * @bug this is not threadsafe - it uses a static buffer
  *
  * @param cluster cluster handle to configure
  * @param var name of the environment variable to read
  * @return 0 on success, negative error code on failure
  */
int rados_conf_parse_env(rados_t cluster, const char *var);

/**
  * Set a configuration option
  *
  * @pre rados_connect() has not been called on the cluster handle
  *
  * @param cluster cluster handle to configure
  * @param option option to set
  * @param value value of the option
  * @return 0 on success, negative error code on failure. -ENOENT is
  * returned when the option is not a Ceph configuration option.
  */
int rados_conf_set(rados_t cluster, const char *option, const char *value);

/**
  * Get the value of a configuration option
  *
  * @param cluster configuration to read
  * @param option which option to read
  * @param buf where to write the configuration value
  * @param len the size of buf in bytes
  * @return 0 on success, negative error code on failure.
  * -ENAMETOOLONG is returned if the buffer is too short to contain the
  * requested value.
  */
int rados_conf_get(rados_t cluster, const char *option, char *buf, 
size_t len);

/** @} config */
